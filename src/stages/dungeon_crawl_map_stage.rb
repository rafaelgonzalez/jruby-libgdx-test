require 'dungeon_level_actor'
require 'dungeon_level_character_actor'
require 'dungeon_crawl_camera'
require 'character_team'

class DungeonCrawlMapStage < Stage

  attr_reader :screen, :dungeon_level_actor

  def initialize(screen)
    super()

    @screen = screen

    viewport.set_camera(DungeonCrawlCamera.new)

    @dungeon_level_actor = DungeonLevelActor.new(Dungeon::Level.new(:default_map))
    self.add_actor(dungeon_level_actor)

    setup_teams
  end

  def setup_teams
    player_character_1 = Character.new('Geralt')
    player_character_2 = Character.new('Syrio')
    player_character_3 = Character.new('Snake')

    vilain_character_1 = Character.new('Diablo')
    vilain_character_2 = Character.new('Baal')
    vilain_character_3 = Character.new('Mephisto')

    player_team = CharacterTeam.new("Player's characters")
    vilains_team = CharacterTeam.new('Vilains')

    player_team.add_character(player_character_1)
    player_team.add_character(player_character_2)
    player_team.add_character(player_character_3)

    vilains_team.add_character(vilain_character_1)
    vilains_team.add_character(vilain_character_2)
    vilains_team.add_character(vilain_character_3)

    dungeon_level_actor.player_team = player_team

    dungeon_level_actor.spawn_character!(DungeonLevelCharacterActor.new(player_character_1), 14, 11)
    dungeon_level_actor.spawn_character!(DungeonLevelCharacterActor.new(player_character_2), 10, 9)
    dungeon_level_actor.spawn_character!(DungeonLevelCharacterActor.new(player_character_3), 7, 12)

    dungeon_level_actor.spawn_character!(DungeonLevelCharacterActor.new(vilain_character_1), 17, 11)
    dungeon_level_actor.spawn_character!(DungeonLevelCharacterActor.new(vilain_character_2), 20, 13)
    dungeon_level_actor.spawn_character!(DungeonLevelCharacterActor.new(vilain_character_3), 18, 14)
  end
end
