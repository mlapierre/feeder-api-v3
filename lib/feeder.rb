require 'log4r'
require 'log4r/yamlconfigurator'
require 'log4r/outputter/datefileoutputter'
require 'feedjira'

require_relative 'feeder/feed'
require_relative 'feeder/feed_repo'
require_relative 'feeder/article'
require_relative 'feeder/feedlist'

require_relative 'db/sqllite_adapter'

include Log4r

module Feeder
  class Feeder

    def initialize
      Log4r::YamlConfigurator.load_yaml_file("#{Dir.pwd}/config/log4r.yml")
      @log = Log4r::Logger["Feeder"]
      # FeedsHelper.log = @log
      # EntriesHelper.log = mech_log
    end

    def fetch_feed(link)
      @log.info "Fetching: #{link}"
      feed_src = Feedjira::Feed.fetch_and_parse link
      @log.warn "Invalid feed. Request returned: #{feed_src.to_s}" if !feed_src.respond_to? :feed_url

      feed = Feed.new
      feed.title = feed_src.title
      feed.description = feed_src.description
      feed.last_modified = feed_src.last_modified
      feed.feed_url = feed_src.feed_url #TODO check if the link found in the xml doesn't match the url
      feed.source_url = feed_src.url
      feed.articles = feed_src.entries
      feed
    rescue Feedjira::NoParserAvailable => err
      raise err
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
end
