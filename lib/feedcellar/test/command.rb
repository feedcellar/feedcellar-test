require "thor"
require "feedcellar/test/server"

module Feedcellar
  module Test
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
