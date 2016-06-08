module Feeder
  class FeederAgent

    def initialize
      @log = Feeder::log
    end

    def fetch_and_save_all_feeds
      old_feeds = Set.new Feed.all.map { |feed| feed.feed_url }
      @log.info "#{old_feeds.count} old feeds"
      new_feeds = Set.new get_feeds_from_opml "data/subscriptions.xml"
      @log.info "#{new_feeds.count} feeds from opml"
      all_feeds = new_feeds.merge old_feeds.merge Set.new Feedlist.feeds
      @log.info "#{all_feeds.count} unique feeds total"

      fetcher = Fetcher.new
      #all_feeds = ["http://securityfocus.com/rss/news.xml"]
      all_feeds.each do |url|
        #feed = Feed.all feed_url: url
        #next if !feed.first.nil?

        @log.info "Fetch feed: #{url}"
        begin
          feed_source = fetcher.fetch_feed url
        rescue Feedjira::NoParserAvailable
          @log.error "No parser for feed: #{url}"
          next
        rescue Feedjira::FetchFailure => err
          @log.error "Fetch failed for feed: #{url}"
          next
        rescue StandardError => err
          #require 'byebug'
          #byebug
          @log.error "#{err.inspect}"
          @log.error err.message
          next
        end

        feed = Feed.all feed_url: feed_source.feed_url
        if feed.first.nil?
          @log.info "New feed: #{feed_source.title}"
          feed = new_feed feed_source, url
        else
          feed = feed.first
        end

        parse_articles(feed_source.entries).each do |article|
          feed.articles << article
        end

        begin
          feed.save
        rescue DataObjects::DataError => err
          @log.error err.message      
        end
      end
    end

    def new_feed feed_src, url
      feed = Feed.create
      feed.title = feed_src.title
      feed.description = feed_src.description
      feed.last_modified_at = feed_src.last_modified
      feed.feed_url = feed_src.feed_url #TODO check if the link found in the xml doesn't match the url
      feed.source_url = feed_src.url
      feed.created_at = Time.now
      feed
    end

    def parse_articles entries
      parsed_articles = []
      entries.each do |source_entry|
        article = Article.all url: source_entry.url
        next unless article.first.nil?

        article = Article.create
        article.title = source_entry.title
        article.url = source_entry.url
        article.author = source_entry.author
        article.content = source_entry.content
        article.summary = source_entry.summary
        article.image = source_entry.image if source_entry.respond_to? 'image'
        article.last_modified_at = source_entry.updated if source_entry.respond_to? 'updated'
        #require 'byebug'
        #byebug
        if source_entry.published.respond_to? 'year' and source_entry.published.year < 0
          article.published_at = Date.parse source_entry.published.strftime "1970-%m-%dT%T%:z"
        else
          article.published_at = source_entry.published
        end
        article.created_at = Time.now

        parsed_articles.push(article)
      end
      @log.info "New articles: #{parsed_articles.length}"
      parsed_articles
    end

    def parse_opml filename
      file = File.open(filename)
      content = file.readlines.join("")
      outlines = OpmlParser.import(content)
      file.close
      outlines
    end

    def get_feeds_from_opml filename
      outlines = parse_opml filename
      outlines.map { |o| o.attributes[:xmlUrl] }.uniq.select { |i| !i.nil? }
    end

  end
end

# f = Feeder::Feeder.new
# f.get_feeds_from_opml "./data/subscriptions.xml"