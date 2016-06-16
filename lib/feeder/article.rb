module Feeder
  class Article
    include DataMapper::Resource

    property :id, Serial
    property :title, Text
    property :author, Text
    property :content, Text
    property :summary, Text
    property :image, Text
    property :created_at, DateTime
    property :last_modified_at, DateTime
    property :published_at, DateTime

    belongs_to :feed, required: false
    belongs_to :url, required: false
    has 1, :page#, required: false

  end
end
