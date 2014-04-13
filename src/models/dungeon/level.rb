class Dungeon
  class Level

    TILE_WIDTH = 32
    TILE_HEIGHT = 32

    MAPS = {
      default_map: 'assets/maps/level_1.tmx'
    }

    attr_reader :tiles, :tiled_map

    def initialize(map_name = nil)
      @tiled_map = nil
      set_map(map_name) if map_name

      @tiles = []
    end

    # Public: Set the map of the Level.
    # A new map is set only if none was previously set.
    #
    # map_name - The String name of the map.
    #
    # Returns the TiledMap that is set.
    def set_map(map_name)
      unless @tiled_map
        verify_map_name(map_name)
        @tiled_map = TmxMapLoader.new.load(MAPS[map_name])
      end
    end

    # Public: Get the Tile at the given coordinates.
    #
    # x - The horizontal position of the presumed Tile.
    # y - The vertical position of the presumed Tile.
    #
    # Returns a Tile if one is found, nil otherwise.
    def tile(x, y)
      discard_empty_tiles!

      if tile = @tiles.select{|tile| tile.x_position == x and tile.y_position == y}.first
        tile
      elsif @tiled_map.get_layers.any? {|layer| layer.get_cell(x, y) }
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

    # Internal: Verifies the given map exists.
    #
    # map_name - The name of the map.
    #
    # Raises a RuntimeError if the given map name does not exist.
    # Returns nothing.
    def verify_map_name(map_name)
      raise RuntimeError.new("Map #{map_name} does not exist") unless MAPS[map_name]
    end
  end
end
