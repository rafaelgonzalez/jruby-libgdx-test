class Dungeon::Level
  class Tile

    attr_reader :x_position, :y_position

    def initialize(x_position, y_position)
      @x_position = x_position
      @y_position = y_position
    end

    def center_x_position
      ((@x_position - 1) * (Dungeon::Level::TILE_WIDTH)) + (Dungeon::Level::TILE_WIDTH / 2)
    end

    def center_y_position
      ((@y_position - 1) * (Dungeon::Level::TILE_HEIGHT)) + (Dungeon::Level::TILE_HEIGHT / 2)
    end

    def has_same_positions_as?(level_tile)
      level_tile.x_position == @x_position and level_tile.y_position == @y_position
    end
  end
end