class DungeonLevel
  def initialize
    @tiled_map = TmxMapLoader.new.load("assets/maps/level_1.tmx")
    @tiled_map_renderer = OrthogonalTiledMapRenderer.new(@tiled_map)
  end

  def draw(camera)
    @tiled_map_renderer.set_view(camera)
    @tiled_map_renderer.render
  end
end