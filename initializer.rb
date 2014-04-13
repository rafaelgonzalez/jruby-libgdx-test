# Define root path

ROOT_PATH = File.dirname(__FILE__)

# Require initializers

initializers_path = File.expand_path(File.join(ROOT_PATH, 'src', 'config', 'initializers'))
$LOAD_PATH << initializers_path

Dir.entries(initializers_path).keep_if {|file| file =~ /(\.rb$)/ }.each do |file|
  require File.join(initializers_path, file)
end
