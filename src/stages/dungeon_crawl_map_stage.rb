require 'dungeon_level_actor'
require 'dungeon_level_character_actor'
require 'dungeon_crawl_camera'
require 'combat_logger'

class DungeonCrawlMapStage < Stage

  attr_reader :combat_logger

  def initialize
    super

    # Instantiate dungeon level and add it to the stage
    dungeon_level_actor = DungeonLevelActor.new(Dungeon::Level.new(:default_map))
    self.add_actor(dungeon_level_actor)

    # Instantiate dungeon level characters and spawn them in the level
    dungeon_level_actor.spawn_character!(DungeonLevelCharacterActor.new(Character.new('Geralt')), 14, 11)
    dungeon_level_actor.spawn_character!(DungeonLevelCharacterActor.new(Character.new('Syrio')), 10, 9)
    dungeon_level_actor.spawn_character!(DungeonLevelCharacterActor.new(Character.new('Snake')), 7, 12)

    # Add camera to viewport
    viewport.set_camera(DungeonCrawlCamera.new)

    # Try input on camera first, then on Stage
    input_multiplexer = InputMultiplexer.new
    input_multiplexer.add_processor(self.get_camera.input_processor)
    input_multiplexer.add_processor(self)
    Gdx.input.set_input_processor(input_multiplexer)

    @combat_logger = CombatLogger.new
  end

  def draw
    super

    @combat_logger.draw
  end
end
