class Dungeon::Level
  class Tile

    attr_reader :x_position, :y_position, :dungeon_level, :cost
    attr_accessor :character

    def initialize(x_position, y_position, cost, dungeon_level)
      @x_position = x_position
      @y_position = y_position
      @cost = cost
      @dungeon_level = dungeon_level
      @character = nil
    end

    # Public: Determines if this Tile can be walked.
    #
    # Returns a Boolean.
    def walkable?
      !difficulty_impossible? and empty?
    end

    def difficulty_impossible?
      cost == false
    end

    def empty?
      !@character
    end

    # Public: Get the Tile adjacent to this Tile in the given direction.
    #
    # direction  - A Direction constant.
    #
    # Returns a Tile or nil if no Tile is found.
    def adjacent_tile(direction)
      destination_tile_x = x_position
      destination_tile_y = y_position

      if [Direction::UP, Direction::DOWN].include? direction
        destination_tile_y += Direction.screen_direction(direction)
      end

      if [Direction::LEFT, Direction::RIGHT].include? direction
        destination_tile_x += Direction.screen_direction(direction)
      end

      dungeon_level.tile(destination_tile_x, destination_tile_y)
    end

    def has_same_positions_as?(level_tile)
      level_tile.x_position == @x_position and level_tile.y_position == @y_position
    end
  end
end
