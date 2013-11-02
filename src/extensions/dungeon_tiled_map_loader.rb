require 'matrix'

class DungeonTiledMapLoader

  attr_reader :tiled_map_file_path, :dungeon

  def initialize(tiled_map_file_path, dungeon)
    @tiled_map_file_path = tiled_map_file_path
    @dungeon = dungeon

    tiled_map
    tiled_map_renderer
    tiled_map_tiles
  end

  def tiled_map
    @tiled_map ||= TmxMapLoader.new.load(tiled_map_file_path)
  end

  def tiled_map_renderer
    @tiled_map_renderer ||= OrthogonalTiledMapRenderer.new(@tiled_map)
  end

  def tiled_map_tiles
    return @tiled_map_tiles if @tiled_map_tiles

    map_width = map_properties.get('width')
    map_height = map_properties.get('height')

    rows = map_width.times.collect do |x|
      map_height.times.collect do |y|
        if @tiled_map.get_layers.any? {|layer| layer.get_cell(x, y) }
          Dungeon::Level::Tile.new(x, y, dungeon)
        end
      end
    end

    @tiled_map_tiles = Matrix.rows(rows)
  end


  private

  def map_properties
    @map_properties ||= @tiled_map.get_properties
  end
end