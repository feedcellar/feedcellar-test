require "thor"
require "feedcellar/test/server"

module Feedcellar
  module Test
    class Command < Thor
      map "-v" => :version

      desc "start", "Start server."
      option :port, :type => :string, :desc => "Lock port number"
      def start
        server = Server.new(options)
        server.start
      end

      desc "version", "Show version number."
      def version
        puts Feedcellar::VERSION
      end
    end
  end
end
