module Feeder
  class Feed
    include DataMapper::Resource

    property :id, Serial
    property :title, Text
    property :subtitle, Text
    property :icon, Text
    property :description, Text
    property :feed_url, Text
    property :source_url, Text
    property :created_at, DateTime
    property :last_modified_at, DateTime
    property :last_fetched_at, DateTime

    has n, :articles

  end
end
