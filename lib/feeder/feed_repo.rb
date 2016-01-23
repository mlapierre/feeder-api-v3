require 'sequel'

module Feeder
  class FeedRepo
    attr_accessor :id, :title, :subtitle, :icon, :description, :feed_url, :source_url, :articles, :last_modified, :last_fetched

    def initialize(adapter)
      @db = adapter
    end

    def save
      ds = @db["INSERT INTO feeds (title, subtitle, description, feed_url, source_url, icon, last_modified, last_fetched, created)" +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                     @title, @subtitle, @description, @feed_url, @source_url, @icon, @last_modified, @last_fetched, Time.now.getutc]
      @id = ds.insert
    end

  end
end
