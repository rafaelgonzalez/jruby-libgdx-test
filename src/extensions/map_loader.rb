class MapLoader

  MAPS = {
    default_map: 'assets/maps/level_1.tmx',
    groto: 'assets/maps/groto.tmx'
  }

  attr_reader :tiled_map, :tiles_array, :map_name

  def initialize(map_name)
    verify_map_name(map_name)

    @map_name = map_name
    @tiled_map = nil
    @tiles_array = []
  end

  def execute!
    @tiled_map = TmxMapLoader.new.load(MAPS[map_name])

    set_tiles_array_from_tiled_map
  end

  private

  # Internal: Verifies the given map exists.
  #
  # map_name - The name of the map.
  #
  # Raises a RuntimeError if the given map name does not exist.
  # Returns nothing.
  def verify_map_name(map_name)
    raise RuntimeError.new("Map #{map_name} does not exist") unless MAPS[map_name]
  end

  def set_tiles_array_from_tiled_map
    tiled_map.get_layers.each do |layer|
      layer.get_height.times do |y|
        layer.get_width.times do |x|
          @tiles_array[y] = [] if @tiles_array[y].nil?

          if layer.get_cell(x, y)
            if layer.get_properties.get('walkable') == 'false'
              @tiles_array[y][x] = false
            else
              @tiles_array[y][x] = 0.0
            end
          elsif !@tiles_array[y][x]
            @tiles_array[y][x] = false
          end
        end
      end
    end
  end
end
