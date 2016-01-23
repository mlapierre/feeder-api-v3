require_relative 'lib/feeder'

#feedlist = Feeder::FeedList.new
feeder = Feeder::Feeder.new
feed = feeder.fetch_feed(Feeder::Feedlist.feeds[1])
puts feed.title
puts feed.save
