require 'coveralls'
Coveralls.wear!

require 'simplecov'
SimpleCov.start do
  add_group "Extensions", "src/extensions"
  add_group "Models", "src/models"
end

require 'initializer'

require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  FactoryGirl.find_definitions
end
