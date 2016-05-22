module Feeder
  class Feed
    include DataMapper::Resource

    property :id, Serial
    property :title, String
    property :subtitle, String
    property :icon, String
    property :description, String
    property :feed_url, String
    property :source_url, String
    property :created_at, DateTime
    property :last_modified_at, DateTime
    property :last_fetched_at, DateTime

    has n, :articles

  end
end
