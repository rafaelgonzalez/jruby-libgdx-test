require 'simplecov'

SimpleCov.start do
  add_group "Game API", "src/api"
  add_group "Game Engine", "src/yet_another_dungeon_crawler"
  add_group "Extensions", "src/extensions"

  add_filter 'initializer'
  add_filter 'spec'
  add_filter 'src/config'
end

require 'initializer'

require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  FactoryGirl.find_definitions
end
