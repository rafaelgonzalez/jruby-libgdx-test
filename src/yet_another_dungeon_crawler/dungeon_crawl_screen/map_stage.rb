require_relative 'map_stage/dungeon_actor'
require_relative 'map_stage/dungeon_level_actor'
require_relative 'map_stage/dungeon_level_character_actor'
require_relative 'map_stage/camera'

class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class MapStage < Stage

      attr_reader :screen, :dungeon, :dungeon_actor, :dungeon_level

      def initialize(screen)
        super()

        @screen = screen

        viewport.set_camera(Camera.new)

        map_loader = MapLoader.new(:groto)
        map_loader.execute!

        @dungeon = Dungeon.new

        @dungeon_actor = DungeonActor.new(dungeon)

        @dungeon_level = Dungeon::Level.new(map_loader.tiles_array, dungeon)

        dungeon_level_actor = DungeonLevelActor.new(dungeon_level, map_loader.tiled_map)

        self.add_actor(dungeon_actor)
        dungeon_actor.add_actor(dungeon_level_actor)

        setup_teams

        spawn_dungeon_characters(dungeon, dungeon_level)
      end

      private

      def setup_teams
        player_character_1 = Character.new('Geralt')
        player_character_2 = Character.new('Syrio')
        player_character_3 = Character.new('Snake')

        vilain_character_1 = Character.new('Diablo')
        vilain_character_2 = Character.new('Baal')
        vilain_character_3 = Character.new('Mephisto')

        player_team = CharacterTeam.new("Player's characters")
        vilains_team = CharacterTeam.new('Vilains', ArtificialIntelligence::EndTurn.new(dungeon_level))

        player_team.add_character(player_character_1)
        player_team.add_character(player_character_2)
        player_team.add_character(player_character_3)

        vilains_team.add_character(vilain_character_1)
        vilains_team.add_character(vilain_character_2)
        vilains_team.add_character(vilain_character_3)

        dungeon.teams.push(player_team, vilains_team)
      end

      def spawn_dungeon_characters(dungeon, dungeon_level)
        characters = dungeon.teams.map(&:characters).flatten

        characters.each do |character|
          while !dungeon_level.spawn_character!(character,
                                         rand(dungeon_level.height),
                                         rand(dungeon_level.width)) do
          end
        end
      end
    end
  end
end
