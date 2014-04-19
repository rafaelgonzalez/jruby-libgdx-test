path = File.expand_path(File.join(ROOT_PATH, 'src'))
$LOAD_PATH << path

%w{ constants extensions models actions actors cameras input_listeners renderers stages}.each do |dir|
  path = File.expand_path(File.join(ROOT_PATH, 'src', dir))

  $LOAD_PATH << path
end

require 'forwardable'

require 'yet_another_dungeon_crawler'

require 'character'
require 'dungeon/level'
require 'dungeon/level/tile'

require 'character_action'
require 'sprite_sheet_loader'
require 'lpc_sprite_sheet_loader'
require 'progress_bar_with_label'
