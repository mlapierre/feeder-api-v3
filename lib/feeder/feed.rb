require 'sequel'

module Feeder
  class Feed
    attr_accessor :id, :title, :subtitle, :icon, :description, :feed_url, :source_url, :articles, :last_modified, :last_fetched

    def initialize
    end

    def save
    end

  end
end
