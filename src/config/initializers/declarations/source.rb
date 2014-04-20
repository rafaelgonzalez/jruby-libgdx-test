path = File.expand_path(File.join(ROOT_PATH, 'src'))
$LOAD_PATH << path

%w{ extensions api }.each do |dir|
  path = File.expand_path(File.join(ROOT_PATH, 'src', dir))

  $LOAD_PATH << path

  Dir[File.join(path, '**', '*.rb')].each { |f| require(f) }
end

require 'forwardable'

require 'yet_another_dungeon_crawler'
