require "sequel"
require 'yaml'

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    config = YAML.load_file('config/database.yml')

    environment = ENV["ENVIRONMENT"] || "development"
    puts "Using environment \"#{environment}\"\n\n"
    config = config[environment]
    db = Sequel.connect("#{config["adapter"]}://#{config["database"]}")
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "data/migrate", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "data/migrate")
    end
  end
end
