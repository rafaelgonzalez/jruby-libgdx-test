module ArtificialIntelligence
  class SearchAndDestroy

    attr_accessor :dungeon_level, :elapsed_time, :character_team
    attr_reader :paths, :targets

    def initialize(dungeon_level)
      @dungeon_level = dungeon_level
      @elapsed_time = 0
      @paths = {}
      @targets = {}
    end

    def execute(delta_time = nil)
      initialize_characters_paths
      find_current_controlled_character_target
      find_current_controlled_character_path
      # move character to location unless can_not_move
      # attack! unless can_not_attack
      # switch character control
    end

    private

    def initialize_characters_paths
      character_team.characters.each do |character|
        paths[character.id] = {} if paths[character.id].nil?
      end
    end

    def find_current_controlled_character_target
      if current_target.nil? or current_target.dead?
        current_target = current_character.dungeon_level.characters.sample
      end
    end

    def find_current_controlled_character_path
      if current_path.empty?
        path = Pathfinder::Astar.new(
          current_character.current_tile,
          current_target.current_tile
        ).find_path!

        current_path = path
      end
    end

    def current_character
      character_team.current_controlled_character
    end

    def current_path
      paths[current_character.id]
    end

    def current_path=(path)
      paths[current_character.id] = path
    end

    def current_target
      targets[current_character.id]
    end

    def current_target=(target)
      targets[current_character.id] = target
    end
  end
end
