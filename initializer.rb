# Define root path

ROOT_PATH = File.dirname(__FILE__)

# Require dependencies

require_relative File.join(ROOT_PATH, 'src', 'config', 'dependencies')

# Require game files

path = File.expand_path(File.join(ROOT_PATH, 'src'))
$LOAD_PATH << path

# Require game API and extensions

%w{ yadc/core/models extensions }.each do |dir|
  path = File.expand_path(File.join(ROOT_PATH, 'src', dir))

  $LOAD_PATH << path

  Dir[File.join(path, '**', '*.rb')].each { |f| require(f) }
end

# Require game engine

require 'yet_another_dungeon_crawler'
