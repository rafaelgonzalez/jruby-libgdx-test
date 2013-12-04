require 'dungeon_level_input_listener'
require 'dungeon_level_map'

class DungeonLevelActor < Group
  TILE_WIDTH = 32
  TILE_HEIGHT = 32

  attr_reader :level_map

  def initialize
    super

    set_name 'Level characters'

    @level_map = DungeonLevelMap.new(:default_map, self)

    @characters = []
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

    if tile = level_map.tile(tile_x, tile_y)
      character.current_tile = tile
      add_actor(character)
      @characters << character
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
    if @controlled_character_index > (@characters.select(&:playable?).size - 1)
      @controlled_character_index = 0
    end

    get_stage.set_keyboard_focus(current_controlled_character)

    get_stage.get_camera.move_to!(
      current_controlled_character.current_tile.center_x_position,
      current_controlled_character.current_tile.center_y_position
    )
  end

  # Public: Get the current character that responds to input.
  #
  # Returns a DungeonLevelCharacter.
  def current_controlled_character
    @characters.select(&:playable?)[@controlled_character_index]
  end

  # Public: Updates the DungeonLevelActor.
  # Overrides Actor#act.
  #
  # Returns nothing.
  def act(delta_time)
    @level_map.tiles.each(&:apply_effects!)
    super
  end

  # Public: Draws the actor.
  # Overrides Actor#draw.
  #
  # Returns noting.
  def draw(sprite_batch, alpha)
    sprite_batch.end
    @level_map.renderer.set_view(get_stage.camera)
    @level_map.renderer.render
    sprite_batch.begin
    draw_characters(sprite_batch, alpha)
  end


  private

  # Internal: Renders the Characters of the Level.
  #
  # Returns nothing.
  def draw_characters(sprite_batch, alpha)
    characters_by_drawing_order.each {|character| character.draw(sprite_batch, alpha) }
  end

  # Internal: Get the Characters in this Level, ordered by descending y_position.
  #
  # Returns an Array of Characaters.
  def characters_by_drawing_order
    @characters.sort_by {|character| character.y_position}.reverse
  end
end