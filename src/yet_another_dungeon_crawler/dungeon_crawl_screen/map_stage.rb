require_relative 'map_stage/dungeon_actor'
require_relative 'map_stage/dungeon_level_actor'
require_relative 'map_stage/dungeon_level_character_actor'
require_relative 'map_stage/camera'

class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class MapStage < Stage

      attr_reader :screen, :dungeon_actor

      def initialize(screen)
        super()

        @screen = screen

        viewport.set_camera(Camera.new)

        map_loader = MapLoader.new(:default_map)
        map_loader.execute!

        dungeon = Dungeon.new
        @dungeon_actor = DungeonActor.new(dungeon)

        dungeon_level = Dungeon::Level.new(map_loader.tiles_array)
        dungeon_level_actor = DungeonLevelActor.new(dungeon_level, map_loader.tiled_map)

        self.add_actor(dungeon_actor)
        dungeon_actor.add_actor(dungeon_level_actor)

        spawn_dungeon_characters(dungeon, dungeon_level)
      end

      private

      def spawn_dungeon_characters(dungeon, dungeon_level)
        characters = dungeon.teams.map(&:characters).flatten

        characters.each do |character|
          dungeon_level.spawn_character!(character,
                                         rand(dungeon_level.height),
                                         rand(dungeon_level.width))
        end
      end
    end
  end
end
