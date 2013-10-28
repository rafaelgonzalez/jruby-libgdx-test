require 'dungeon_level_character_input_listener'
require 'dungeon_level_character_actions_manager'
require 'dungeon_level_character_actor_renderer'

class DungeonLevelCharacterActor < Actor
  include DungeonLevelCharacterActorRenderer
  include DungeonLevelCharacterActionsManager

  attr_accessor :current_action, :current_direction, :current_tile
  attr_reader :destination_tile

  def initialize(x_position, y_position)
    super()

    @current_action = CharacterAction::STAND
    @current_direction = Direction::RIGHT

    @current_tile = Dungeon::Level::Tile.new(x_position, y_position)
    @destination_tile = Dungeon::Level::Tile.new(x_position, y_position)

    @state_time = 0.0

    initialize_rendering

    set_height(LpcSpriteSheetLoader::SPRITE_HEIGHT)
    set_width(LpcSpriteSheetLoader::SPRITE_WIDTH)
    set_x(current_tile.character_x_position)
    set_y(current_tile.character_y_position)

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

  # Public: Determines if the Character is moving.
  #
  # Returns a Boolean.
  def is_moving?
    current_action == CharacterAction::WALK
  end
end