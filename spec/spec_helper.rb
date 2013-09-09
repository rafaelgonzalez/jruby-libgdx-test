require 'coveralls'
Coveralls.wear!

require 'simplecov'
SimpleCov.start do
  add_group "Extensions", "src/extensions"
  add_group "Models", "src/models"
end

require 'initializer'