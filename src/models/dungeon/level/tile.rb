class Dungeon::Level
  class Tile

    attr_reader :x_position, :y_position

    def initialize(x_position, y_position)
      @x_position = x_position
      @y_position = y_position
    end

    def character_x_position
      x_position * Dungeon::Level::TILE_WIDTH
    end

    def character_y_position
      (y_position * Dungeon::Level::TILE_HEIGHT) + DungeonLevelCharacterActorRenderer::CHARACTER_GROUND_OFFSET
    end

    def has_same_positions_as?(level_tile)
      level_tile.x_position == @x_position and level_tile.y_position == @y_position
    end
  end
end