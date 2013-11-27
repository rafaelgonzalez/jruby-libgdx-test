class DungeonLevelMap

  MAPS = {
    default_map: 'assets/maps/level_1.tmx'
  }

  attr_reader :dungeon, :renderer

  def initialize(map_name, dungeon)
    verifiy_map_name(map_name)

    @dungeon = dungeon

    @tiled_map = TmxMapLoader.new.load(MAPS[map_name])
    @renderer = OrthogonalTiledMapRenderer.new(@tiled_map)
    @tiles = []
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
      new_tile = Dungeon::Level::Tile.new(x, y, dungeon)
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
  def verifiy_map_name(map_name)
    raise RuntimeError.new("Map #{map_name} does not exist") unless MAPS[map_name]
  end
end