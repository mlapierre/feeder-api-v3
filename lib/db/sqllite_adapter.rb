require 'sequel'

module DB
  class SqlliteAdapter

    def initialize
      config = YAML.load_file('config/database.yml')
      environment = ENV["ENVIRONMENT"] || "development"
      puts "Using environment \"#{environment}\"\n\n"
      config = config[environment]
      @db = Sequel.connect("#{config["adapter"]}://#{config["database"]}")
    end

    def save
      ds = @db["INSERT INTO feeds (title, subtitle, description, feed_url, source_url, icon, last_modified, last_fetched, created)" +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                     @title, @subtitle, @description, @feed_url, @source_url, @icon, @last_modified, @last_fetched, Time.now.getutc]
      @id = ds.insert
    end

  end
end
