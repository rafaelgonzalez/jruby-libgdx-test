require 'rawr'
require 'rspec/core/rake_task'

Dir.glob('src/tasks/*.rake').each { |r| import r }

task :default => :spec
RSpec::Core::RakeTask.new