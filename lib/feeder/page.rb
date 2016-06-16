module Feeder
  class Page
    include DataMapper::Resource

    property :id, Serial
    property :title, Text
    property :content, Text
    property :created_at, DateTime

    belongs_to :article, required: false
    belongs_to :url, required: false
    has n, :headers  

  end
end