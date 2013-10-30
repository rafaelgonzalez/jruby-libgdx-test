class DungeonLevelActor < Actor
  TILE_WIDTH = 32
  TILE_HEIGHT = 32

  def initialize
    super

    @tiled_map = TmxMapLoader.new.load("assets/maps/level_1.tmx")
    @tiled_map_renderer = OrthogonalTiledMapRenderer.new(@tiled_map)
  end

  # Public: Called by the framework when this actor or any parent is added to a group that is in the stage.
  # Overrides Actor#setStage.
  #
  # Returns nothing.
  def setStage(stage)
    super
    unless stage.nil?
      @characters_group = Group.new
      @characters_group.set_name 'Level characters'
      stage.add_actor(@characters_group)
    end
  end

  # Public: Spawns a DungeonLevelCharacterActor into the map.
  # Checks a Tile exists at the given coordinates.
  # Assigns the given tile to the DungeonLebelCharacter.
  # Adds the DungeonLevelCharacterActor to the Stage.
  #
  # character - The DungeonLevelCharacterActor to spawn.
  # tile_x    - The Tile's horizontal posititon.
  # tile_y    - The Tile's vertical posititon.
  #
  # Raises a RuntimeError if the DungeonLevelActor was not previously assigned to a Stage.
  # Returns true if the character was successfully spawned, false otherwise.
  def spawn_character!(character, tile_x, tile_y)
    raise RuntimeError.new('Cannot spawn a character in a level without a stage') if get_stage.nil?

    if tile?(tile_x, tile_y)
      character.current_tile = Dungeon::Level::Tile.new(tile_x, tile_y, self)
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

  # Public: Get all the characters spawned in this level.
  #
  # Returns an Array of DungeonLevelCharacters.
  def characters
    @characters_group.get_children
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

  # Public: Draws the actor.
  # Overrides Actor#draw.
  #
  # Returns noting.
  def draw(sprite_batch, alpha)
    sprite_batch.end
    @tiled_map_renderer.set_view(get_stage.camera)
    @tiled_map_renderer.render
    sprite_batch.begin
  end
end