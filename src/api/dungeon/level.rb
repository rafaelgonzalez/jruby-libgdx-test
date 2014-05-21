class Dungeon
  class Level

    attr_reader :tiles_array, :tiles, :characters, :dungeon

    def initialize(tiles_array, dungeon)
      @tiles_array = tiles_array
      @dungeon = dungeon
      @tiles = []
      @characters = []
    end

    # Public: Spawns a Character into the Level.
    # Checks a Tile exists at the given coordinates.
    # Assigns the given tile to the Character.
    #
    # character - The Character to spawn.
    # tile_x    - The Tile's horizontal posititon.
    # tile_y    - The Tile's vertical posititon.
    #
    # Returns true if the character was successfully spawned, false otherwise.
    def spawn_character!(character, x, y)
      tile = tile(x, y)

      if tile and tile.walkable?
        character.current_tile = tile
        @characters.push(character)
        true
      else
        false
      end
    end

    # Public: Get the Tile at the given coordinates.
    #
    # x - The horizontal position of the presumed Tile.
    # y - The vertical position of the presumed Tile.
    #
    # Returns a Tile if one is found, nil otherwise.
    def tile(x, y)
      return nil if (x < 0) or (y < 0)

      if tile = @tiles.select{|tile| tile.x_position == x and tile.y_position == y}.first
        tile
      elsif tiles_array[y] and (tiles_array[y][x] or tiles_array[y][x] == false)
        new_tile = Dungeon::Level::Tile.new(x, y, tiles_array[y][x], self)
        @tiles.push new_tile
        new_tile
      else
        nil
      end
    end

    def height
      tiles_array.size
    end

    def width
      if tiles_array[0]
        tiles_array[0].size
      else
        0
      end
    end
  end
end
