require_relative 'lib/feeder'
require 'byebug'
#feedlist = Feeder::FeedList.new
# fetcher = Feeder::Fetcher.new
# feed = fetcher.fetch_feed(Feeder::Feedlist.feeds[1])
# #puts feed.title
# #puts feed.title
# feed.save
# #puts Feeder::Feed.first
# puts "Feed: #{feed.title}"
# puts "Articles: #{Feeder::Feed.first.articles.length}"
# puts "Article: #{Feeder::Feed.first.articles.first.title}"

feeder = Feeder::Feeder.new
feeder.fetch_and_save_all_feeds
