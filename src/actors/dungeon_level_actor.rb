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
      character.current_tile = Dungeon::Level::Tile.new(x, y, self)
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

  # Public: Get the Tile adjacent to the given Tile in the given direction.
  #
  # start_tile - The Tile from which the adjacent Tile search is made.
  # direction  - A Direction constant.
  #
  # Returns a Tile or nil if no Tile is found.
  def adjacent_tile_from_direction(start_tile, direction)
    destination_tile_x = start_tile.x_position
    destination_tile_y = start_tile.y_position

    if [Direction::UP, Direction::DOWN].include? direction
      destination_tile_y += Direction.screen_direction(direction)
    end

    if [Direction::LEFT, Direction::RIGHT].include? direction
      destination_tile_x += Direction.screen_direction(direction)
    end

    if tile?(destination_tile_x, destination_tile_y)
      Dungeon::Level::Tile.new(destination_tile_x, destination_tile_y, self)
    end
  end

  def draw(sprite_batch, alpha)
    sprite_batch.end
    @tiled_map_renderer.set_view(get_stage.camera)
    @tiled_map_renderer.render
    sprite_batch.begin
  end
end