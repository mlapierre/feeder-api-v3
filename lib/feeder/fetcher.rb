module Feeder
  class Fetcher

    def initialize
    end

    def fetch_feed(link)
      fetch_and_parse link
    end

    def fetch_and_parse(link)
      Feedjira::Feed.fetch_and_parse link
    end

    def fetch_page url
      page = {}
      open(url) do |p|
        n = Nokogiri::HTML(p)
        page[:title] = n.title
        page[:content] = n.to_html
        page[:headers] = p.meta
      end
      page
    end

  end
end

