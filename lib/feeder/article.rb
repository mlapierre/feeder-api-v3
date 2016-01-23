require 'sequel'

module Feeder
  class Feed
    attr_accessor :id, :title, :url, :author, :content, :summary, :image, :created, :last_modified, :published

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
