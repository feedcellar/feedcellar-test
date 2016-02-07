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
            item.description = <<-DESCRIPTION
Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, `and what is the use of a book,' thought Alice `without pictures or conversation?'

So she was considering in her own mind (as well as she could, for the hot day made her feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be worth the trouble of getting up and picking the daisies, when suddenly a White Rabbit with pink eyes ran close by her.
            DESCRIPTION
            item.date = Time.parse("2016/2/#{i} 00:00")
          end
        end

        rss
      end
    end
  end
end

