require_relative 'lib/feeder'

#feedlist = Feeder::FeedList.new
fetcher= Feeder::Fetcher.new
feed = fetcher.fetch_feed(Feeder::Feedlist.feeds[1])
puts feed.title
puts feed.save
