require 'log4r'
require 'log4r/yamlconfigurator'
require 'log4r/outputter/datefileoutputter'
require 'feedjira'
require 'dm-core'
require 'dm-migrations'

require_relative 'feeder/article'
require_relative 'feeder/feed'
require_relative 'feeder/feeder_data'
require_relative 'feeder/feeder'
require_relative 'feeder/feedlist'
require_relative 'feeder/fetcher'

#require_relative 'db/sqllite_adapter'

include Log4r

module Feeder
  Log4r::YamlConfigurator.load_yaml_file("#{Dir.pwd}/config/log4r.yml")
  @@log = Log4r::Logger["Feeder"]

  FeederData.init

  def self.log
    @@log
  end

    # def update_feeds
    #   # TODO allow update frequency to be restricted
    #   @log.info "Queuing feeds..."
    #   Feed.find_each.with_index do |feed, index|
    #     @log.debug "Queuing: #{feed.title} [#{index+1}/#{Feed.count}]"
    #     async_update_feed(feed.id)
    #   end
    #   @log.info "All feeds queued"
    # end
    #
    # def async_update_feed(feed_id)
    #   Resque.enqueue(UpdateFeedJob, feed_id)
    # end
    #
    # def import_opml_from(file)
    #   @log.info "Importing opml: #{file}"
    #   FeedsHelper.import_opml_from(file)
    # end

end
