module ArtificialIntelligence
  class SearchAndDestroy

    attr_accessor :character
    attr_reader :path, :target

    def initialize(character)
      @dungeon_level = dungeon_level
      @path = []
      @target = nil
    end

    def execute(delta_time = nil)
      choose_target
      create_path_to_target

      # move character to location unless can_not_move
      # attack! unless can_not_attack
      # end character turn
    end

    private

    def choose_target
      if current_target.nil? or current_target.dead?
        path = find_shortest_path
        target =
      end
    end

    def find_shortest_path
      targets.map do |target|
        Pathfinder::Astar.new(
          current_character.current_tile,
          current_target.current_tile
        ).find_path!
      end.sort_by(&:length)
    end

    def current_character
      @character = @character_team.current_controlled_character
    end

    def dungeon_level
      current_character.dungeon_level
    end
  end
end
