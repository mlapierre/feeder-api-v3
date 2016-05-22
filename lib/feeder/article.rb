module Feeder
  class Article
    include DataMapper::Resource

    property :id, Serial
    property :title, String
    property :url, String
    property :author, String
    property :content, Text
    property :summary, Text
    property :image, String
    property :created_at, DateTime
    property :last_modified_at, DateTime
    property :published_at, DateTime

    belongs_to :feed

    # def initialize(adapter)
    #   @db = adapter
    # end

    # def save
    #   ds = @db["INSERT INTO feeds (title, subtitle, description, feed_url, source_url, icon, last_modified, last_fetched, created)" +
    #                  "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
    #                  @title, @subtitle, @description, @feed_url, @source_url, @icon, @last_modified, @last_fetched, Time.now.getutc]
    #   @id = ds.insert
    # end

  end
end
