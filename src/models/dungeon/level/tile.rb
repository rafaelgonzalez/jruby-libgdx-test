class Dungeon::Level
  class Tile

    attr_reader :x_position, :y_position, :dungeon_level
    attr_accessor :character

    def initialize(x_position, y_position, dungeon_level)
      @x_position = x_position
      @y_position = y_position
      @dungeon_level = dungeon_level
      @character = nil
    end

    # Public: Determines if this Tile can be walked.
    #
    # Returns a Boolean.
    def walkable?
      !@character
    end

    def character_x_position
      (x_position * Dungeon::Level::TILE_WIDTH) - (Dungeon::Level::TILE_WIDTH / 2)
    end

    def character_y_position
      (y_position * Dungeon::Level::TILE_HEIGHT) -
      (Dungeon::Level::TILE_HEIGHT / 2) +
      DungeonLevelCharacterActorRenderer::CHARACTER_GROUND_OFFSET
    end

    def center_x_position
      (x_position * Dungeon::Level::TILE_WIDTH) + (Dungeon::Level::TILE_WIDTH / 2)
    end

    def center_y_position
      (y_position * Dungeon::Level::TILE_HEIGHT) + (Dungeon::Level::TILE_HEIGHT / 2)
    end

    def has_same_positions_as?(level_tile)
      level_tile.x_position == @x_position and level_tile.y_position == @y_position
    end
  end
end