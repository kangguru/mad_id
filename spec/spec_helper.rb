$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'mad_id'
require 'rspec'
require 'rspec/collection_matchers'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.order = "random"
end
