# Define root path

ROOT_PATH = File.dirname(__FILE__)

path = File.expand_path(File.join(ROOT_PATH, 'src'))
$LOAD_PATH << path

require 'yadc'
