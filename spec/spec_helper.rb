require 'simplecov'
SimpleCov.start do
  add_group "Extensions", "src/extensions"
  add_group "Input", "src/input"
  add_group "Models", "src/models"
  add_group "Renderers", "src/renderers"
end

require 'initializer'