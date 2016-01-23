Dir['lib/tasks/**/*.rake'].each { |r| import r }

require 'rake'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task :test    => :spec
task :default => :spec
