source 'https://rubygems.org'
source 'http://gems.neurogami.com'

gem 'activesupport'

group :development do
  gem 'rawr', '~> 1.7.0'
  gem 'pry'
end

group :test do
  gem 'rake' # Needed for travis
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'cane'
  gem 'codeclimate-test-reporter', require: false
end

group :development, :test do
  gem 'factory_girl'
end
