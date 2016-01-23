require 'simplecov'
# SimpleCov.start do
#   add_filter '/spec/'
# end

require 'pry'
require 'cgu_remitcentral_automation'

project_root = Pathname.new(File.expand_path(File.join(File.basename(__FILE__), %w(..))))
#Dir[project_root.join("features/support/pages/*.rb")].each {|f| require f}
#Dir[project_root.join("features/support/helpers/*.rb")].each {|f| require f}

include Feeder

RSpec.configure do |c|
  # declare an exclusion filter
  c.filter_run_excluding disabled: true
  c.order = "random"
end
