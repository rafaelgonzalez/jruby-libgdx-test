require 'dungeon_level_character_input_listener'
require 'dungeon_level_character_input_translator'
require 'dungeon_level_character_actor_renderer'

require 'models/skills'

class DungeonLevelCharacterActor < Actor
  include DungeonLevelCharacterActorRenderer

  extend Forwardable

  attr_accessor :current_action
  attr_reader :input_translator, :character

  def_delegators :@character, :current_tile, :destination_tile, :x_position, :y_position,
                              :current_direction, :armor, :health, :use_skill!, :alive?,
                              :playable?, :reset_for_new_turn!, :name, :maximum_stamina,
                              :maximum_mana, :stamina, :mana, :maximum_health

  def initialize(character)
    super()

    @character = character
    character.actor = self

    @current_action = CharacterAction::STAND

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

    @current_action = CharacterAction::DEATH unless alive?
  end

  def current_tile=(new_tile)
    character.current_tile = new_tile

    set_x(current_tile.character_x_position)
    set_y(current_tile.character_y_position)
  end

  # Public: Determines if the Character is moving.
  #
  # Returns a Boolean.
  def is_moving?
    @current_action == CharacterAction::WALK
  end

  def log_message(message)
    get_stage.combat_logger.add_message(message)
  end
end
