class DungeonLevelActor < Actor
  TILE_WIDTH = 32
  TILE_HEIGHT = 32

  def initialize
    super

    @tiled_map = TmxMapLoader.new.load("assets/maps/level_1.tmx")
    @tiled_map_renderer = OrthogonalTiledMapRenderer.new(@tiled_map)
  end

  def setStage(stage)
    super
    unless stage.nil?
      @characters_group = Group.new
      @characters_group.set_name 'Level characters'
      stage.add_actor(@characters_group)
    end
  end

  def spawn_character!(character, x, y)
    raise RuntimeError.new('Cannot spawn a character in a level without a stage') if get_stage.nil?

    if tile?(x, y)
      @characters_group.add_actor(character)
      true
    else
      false
    end
  end

  # Public: Determines if a Tile exists at the given coordinates
  #
  # x - The horizontal position of the presumed Tile.
  # y - The vertical position of the presumed Tile.
  #
  # Returns a Boolean.
  def tile?(x, y)
    @tiled_map.get_layers.any? {|layer| layer.get_cell(x, y) }
  end

  def draw(sprite_batch, alpha)
    sprite_batch.end
    @tiled_map_renderer.set_view(get_stage.camera)
    @tiled_map_renderer.render
    sprite_batch.begin
  end
end