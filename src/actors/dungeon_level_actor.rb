require 'dungeon_level_input_listener'
require 'dungeon_tiled_map_loader'

class DungeonLevelActor < Group
  TILE_WIDTH = 32
  TILE_HEIGHT = 32

  def initialize
    super

    set_name 'Level characters'

    tiled_map_loader = DungeonTiledMapLoader.new("assets/maps/level_1.tmx", self)

    @tiled_map = tiled_map_loader.tiled_map
    @tiled_map_renderer = tiled_map_loader.tiled_map_renderer
    @tiles = tiled_map_loader.tiled_map_tiles

    @controlled_character_index = 0

    add_listener(DungeonLevelInputListener.new(self))
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

    if tile = tile(tile_x, tile_y)
      character.current_tile = tile
      add_actor(character)
      get_stage.set_keyboard_focus(current_controlled_character)
      true
    else
      false
    end
  end

  # Public: Gives keyboard focus to the next Character in the list, and moves Camera to the Character.
  #
  # Returns nothing.
  def switch_control_to_next_character!
    @controlled_character_index += 1
    @controlled_character_index = 0 if @controlled_character_index > (characters.size - 1)
    get_stage.set_keyboard_focus(current_controlled_character)

    get_stage.get_camera.move_to!(
      current_controlled_character.current_tile.center_x_position,
      current_controlled_character.current_tile.center_y_position
    )
  end

  # Public: Gte the Tile at the given coordinates
  #
  # x - The horizontal position of the presumed Tile.
  # y - The vertical position of the presumed Tile.
  #
  # Returns a Tile if one is found, nil otherwise.
  def tile(x, y)
    return nil if x < 0 or y < 0
    @tiles[x, y]
  end

  # Public: Get all the characters spawned in this level.
  #
  # Returns an Array of DungeonLevelCharacters.
  def characters
    get_children.to_array
  end

  # Public: Get the current character that responds to input.
  #
  # Returns a DungeonLevelCharacter.
  def current_controlled_character
    characters[@controlled_character_index]
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

    tile(destination_tile_x, destination_tile_y)
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
    super
  end
end