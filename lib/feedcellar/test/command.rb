require "thor"
require "thor/group"
require "rss"
require "webrick"

module Feedcellar
  module Test
    class Server < Thor
      desc "server start", "Start server."
      def start
        srv_proc = lambda do
          config = {
            :DocumentRoot => './',
            :BindAddress => '127.0.0.1',
            :Port => 20075
          }
          srv = WEBrick::HTTPServer.new(config)
          trap("INT") { srv.shutdown }
          srv.start
        end

        if File.basename($0) == "feedcellar-test"
          srv_proc.call
        else
          if @server
            @server.run
          else
            @server = Thread.start do
              config = {
                :DocumentRoot => './',
                :BindAddress => '127.0.0.1',
                :Port => 20075
              }
              srv = WEBrick::HTTPServer.new(config)
              trap("INT") { srv.shutdown }
              srv.start
            end
          end
        end
      end

      desc "server stop", "Stop server."
      def stop
        if @server
          @server.stop
        else
          $stderr.puts("Server is not run.")
          return false
        end
      end
    end

    class Command < Thor
      map "-v" => :version

      register(Server, "server", "server start/stop", "server commands.")

      desc "version", "Show version number."
      def version
        puts Feedcellar::VERSION
      end
    end
  end
end
