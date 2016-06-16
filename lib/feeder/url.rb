module Feeder
  class Url
    include DataMapper::Resource

    property :id, Serial
    property :url, Text
    property :created_at, DateTime

    has 1, :page, required: false
    has 1, :article#, required: false

  end
end