require 'clockwork'
require_relative 'feeder'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(1.hour, 'save_feeds') do
    feeder = Feeder::FeederAgent.new
    feeder.fetch_and_save_all_feeds
  end
end
