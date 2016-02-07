require "rss"
require "feedcellar/test/config"

module Feedcellar
  module Test
    class Feed
      def self.make
        rss = RSS::Maker.make("2.0") do |maker|
          maker.channel.about = File.join(BASE_URL, "feed.xml")
          maker.channel.title = "Feedcellar Test"
          maker.channel.description = "Test Site"
          maker.channel.link = BASE_URL

          1.upto(3) do |i|
            item = maker.items.new_item
            item.link = File.join(BASE_URL, "article#{i}.html")
            item.title = "Sample Article #{i}"
            item.date = Time.parse("2016/2/#{i} 00:00")
          end
        end

        rss
      end
    end
  end
end

