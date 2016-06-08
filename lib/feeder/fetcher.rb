module Feeder
  class Fetcher

    def initialize
      #@log = Feeder.log
      # FeedsHelper.log = @log
      # EntriesHelper.log = mech_log
    end

    def fetch_feed(link)
      #@log.info "Fetching: #{link}"
      feed_src = fetch_and_parse link
      #@log.warn "Invalid feed. Request returned: #{feed_src.to_s}" if !feed_src.respond_to? :feed_url

      feed_src
    end

    def fetch_and_parse(link)
      Feedjira::Feed.fetch_and_parse link
    end

  end
end

