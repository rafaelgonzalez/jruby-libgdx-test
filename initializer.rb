# Define root path

ROOT_PATH = File.dirname(__FILE__)

# Require dependencies

require_relative File.join(ROOT_PATH, 'src', 'config', 'dependencies')

# Require game files

path = File.expand_path(File.join(ROOT_PATH, 'src'))
$LOAD_PATH << path

require 'yadc'
