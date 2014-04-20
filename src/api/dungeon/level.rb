class Dungeon
  class Level

    TILE_WIDTH = 32
    TILE_HEIGHT = 32

    attr_reader :tiles_array, :tiles

    def initialize(tiles_array)
      @tiles_array = tiles_array
      @tiles = []
    end

    # Public: Get the Tile at the given coordinates.
    #
    # x - The horizontal position of the presumed Tile.
    # y - The vertical position of the presumed Tile.
    #
    # Returns a Tile if one is found, nil otherwise.
    def tile(x, y)
      return nil if (x < 0) or (y < 0)

      discard_empty_tiles!

      if tile = @tiles.select{|tile| tile.x_position == x and tile.y_position == y}.first
        tile
      elsif tiles_array[y] and tiles_array[y][x]
        new_tile = Dungeon::Level::Tile.new(x, y, self)
        @tiles.push new_tile
        new_tile
      else
        nil
      end
    end

    private

    # Internal: Discard tiles that have no characters on them, in order to free up memory.
    #
    # Returns nothing.
    def discard_empty_tiles!
      @tiles = @tiles.select {|tile| tile.character }
    end
  end
end
