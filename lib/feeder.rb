require 'dm-core'
require 'dm-migrations'
require 'feedjira'
require 'log4r'
require 'log4r/yamlconfigurator'
require 'log4r/outputter/datefileoutputter'
require 'nokogiri'
require 'opml-parser'
require 'open-uri'

require 'byebug'

require_relative 'feeder/article'
require_relative 'feeder/feed'
require_relative 'feeder/feeder_data'
require_relative 'feeder/feeder_agent'
require_relative 'feeder/feedlist'
require_relative 'feeder/fetcher'
require_relative 'feeder/header'
require_relative 'feeder/page'

include Log4r
include OpmlParser

module Feeder
  
  Log4r::YamlConfigurator.load_yaml_file("#{Dir.pwd}/config/log4r.yml")
  @@log = Log4r::Logger["Feeder"]

  FeederData.init

  def self.log
    @@log
  end
    
end
