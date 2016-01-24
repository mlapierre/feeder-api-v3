module Feeder
  class Fetcher

    def initialize
      @log = Feeder.log
      # FeedsHelper.log = @log
      # EntriesHelper.log = mech_log
    end

    def fetch_feed(link)
      @log.info "Fetching: #{link}"
      feed_src = fetch_and_parse link
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

    def fetch_and_parse(link)
      Feedjira::Feed.fetch_and_parse link
    end

  end
end
