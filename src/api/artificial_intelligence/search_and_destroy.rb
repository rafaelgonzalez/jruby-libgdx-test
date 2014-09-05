module ArtificialIntelligence
  class SearchAndDestroy

    attr_accessor :dungeon_level, :character_team
    attr_reader :path, :target

    def initialize(dungeon_level)
      @dungeon_level = dungeon_level
      @path = []
      @target = nil
    end

    def execute(delta_time = nil)
      choose_target

      # move character to location unless can_not_move
      # attack! unless can_not_attack
      # end character turn

      dungeon.end_current_playing_team_turn!
    end

    private

    def choose_target
      path = find_shortest_path
      MoveCharacter.new(path).execute
    end

    def find_shortest_path
      targets.map do |target|
        Pathfinder::AStar.new(
          current_character.current_tile,
          target.current_tile
        ).find_path!
      end.sort_by(&:length)
    end

    def targets
      binding.pry
      # dungeon.teams.flat_map do |team|
      #   next if team == character_team
      #   team.characters
      # end
    end

    def current_character
      @character = @character_team.current_controlled_character
    end

    def dungeon
      dungeon_level.dungeon
    end
  end
end
