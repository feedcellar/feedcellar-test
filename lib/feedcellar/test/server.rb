require "thor"
require "webrick"
require "tmpdir"
require "feedcellar/test/config"
require "feedcellar/test/feed"

module Feedcellar
  module Test
    class Server < Thor
      def initialize(*args)
        super
        @tmpdir = Dir.mktmpdir("feedcellar-test")
        File.write(File.join(@tmpdir, "feed.xml"),
                   Feed.make)
      end

      desc "server start", "Start server."
      option :silent, :type => :boolean, :desc => "Stop logging."
      def start
        srv_proc = lambda do
          config = {
            :DocumentRoot => './',
            :BindAddress => '127.0.0.1',
            :Port => PORT,
          }
          if options[:silent]
            config[:Logger] = WEBrick::Log.new(File.open(File::NULL, "w"))
            config[:AccessLog] = []
          end
          Dir.chdir(@tmpdir) do
            srv = WEBrick::HTTPServer.new(config)
            trap("INT") { srv.shutdown }
            srv.start
          end
        end

        if File.basename($0) == "feedcellar-test"
          srv_proc.call
        else
          if @server && @server.alive?
            $stderr.puts("Server is still running.")
            return false
          end
          @server = Thread.start(&srv_proc)
        end
      end

      desc "server stop", "Stop server."
      def stop
        if @server && @server.alive?
          @server.kill
        else
          $stderr.puts("Server is not run.")
          return false
        end
      end
    end
  end
end
