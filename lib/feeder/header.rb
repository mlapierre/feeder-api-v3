module Feeder
  class Header
    include DataMapper::Resource

    property :id, Serial
    property :header, Text
    property :value, Text

    belongs_to :page
  end
end