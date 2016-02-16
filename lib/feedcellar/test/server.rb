require "thor"
require "webrick"
require "tmpdir"
require "feedcellar/test/feed"

module Feedcellar
  module Test
    class Server
      attr_reader :port, :base_url
      def initialize(options={})
        @tmpdir = Dir.mktmpdir("feedcellar-test")
        @port = options[:port] || 20000 + rand(5000)
        @base_url = "http://localhost:#{@port}"
        File.write(File.join(@tmpdir, "feed.xml"),
                   Feed.make(@base_url))
      end

      def start
        config = {
          :DocumentRoot => './',
          :BindAddress => '127.0.0.1',
          :Port => @port,
        }

        srv_proc = lambda do
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
          config[:Logger] = WEBrick::Log.new(File.open(File::NULL, "w"))
          config[:AccessLog] = []
          @server = Thread.start(&srv_proc)
        end
      end

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
