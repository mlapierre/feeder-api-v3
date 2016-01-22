require 'log4r'
require 'log4r/yamlconfigurator'
require 'log4r/outputter/datefileoutputter'
require 'feedjira'

include Log4r

class Feeder

  def initialize
    Log4r::YamlConfigurator.load_yaml_file("#{Dir.pwd}/config/log4r.yml")
    @log = Log4r::Logger["Feeder"]
    # FeedsHelper.log = @log
    # EntriesHelper.log = mech_log
  end

  def fetch_feed(link)
    @log.info "Fetching: #{link}"
    feed = Feedjira::Feed.fetch_and_parse link
    @log.warn "Invalid feed. Request returned: #{feed.to_s}" if !feed.respond_to? :feed_url

    doc = {
      'type' => 'feed',
      'title' => feed.title,
      'description' => feed.description,
      'last_modified' => feed.last_modified,
      'feed_link' => feed.feed_url, #TODO check if the link found in the xml doesn't match the url
      'website_link' => feed.url,
      'articles' => feed.entries
    }
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
