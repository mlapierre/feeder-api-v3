module Feeder
  class Feeder

    def initialize
    end

    def fetch_and_save_all_feeds
      fetcher = Fetcher.new
      Feedlist.feeds.each do |url|
        puts "Fetch feed: #{url}"
        feed_source = fetcher.fetch_feed url
        feed = Feed.all feed_url: feed_source.feed_url
        if feed.first.nil?
          puts "New feed: #{feed_source.title}"
          feed = new_feed feed_source, url
        end
        parse_articles(feed_source.entries).each do |article|
          feed.articles << article
        end
        feed.save
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
        article.published_at = source_entry.published
        article.created_at = Time.now

        parsed_articles.push(article)
      end
      puts "New articles: #{parsed_articles.length}"
      parsed_articles
    end

  end
end