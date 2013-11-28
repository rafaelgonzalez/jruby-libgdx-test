require 'dungeon_level_character_input_listener'
require 'dungeon_level_character_input_translator'
require 'dungeon_level_character_actions_manager'
require 'dungeon_level_character_actor_renderer'

class DungeonLevelCharacterActor < Actor
  include DungeonLevelCharacterActorRenderer
  include DungeonLevelCharacterActionsManager

  attr_accessor :current_action, :current_direction, :current_tile, :destination_tile
  attr_reader :input_translator

  def initialize
    super

    @current_action = CharacterAction::STAND
    @current_direction = Direction::RIGHT

    @current_tile = nil
    @destination_tile = nil

    @state_time = 0.0

    initialize_rendering

    set_height(LpcSpriteSheetLoader::SPRITE_HEIGHT)
    set_width(LpcSpriteSheetLoader::SPRITE_WIDTH)

    @input_translator = DungeonLevelCharacterInputTranslator.new(self)

    add_listener(DungeonLevelCharacterInputListener.new(self))
  end

  # Public: Updates the DungeonLevelCharacterActor.
  # Overrides Actor#act.
  #
  # Returns nothing.
  def act(delta_time)
    @state_time += delta_time
    super
  end

  def x_position
    current_tile.x_position
  end

  def y_position
    current_tile.y_position
  end

  def current_tile=(current_tile)
    @current_tile.character = nil unless @current_tile.nil?
    current_tile.character = self

    @current_tile = @destination_tile = current_tile

    set_x(current_tile.character_x_position)
    set_y(current_tile.character_y_position)
  end

  # Public: Determines if the Character is moving.
  #
  # Returns a Boolean.
  def is_moving?
    current_action == CharacterAction::WALK
  end

  private

  # Internal: Returns the DungeonLevelActor the Character is actually in,
  # accessed through the Character's current Tile.
  #
  # Returns a DungeonLevelActor.
  def dungeon_level
    current_tile.dungeon_level
  end
end