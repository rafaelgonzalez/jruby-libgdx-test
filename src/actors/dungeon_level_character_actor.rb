require 'dungeon_level_character_input_listener'
require 'dungeon_level_character_input_translator'
require 'dungeon_level_character_actor_renderer'

require 'models/skills'

class DungeonLevelCharacterActor < Actor
  include DungeonLevelCharacterActorRenderer

  attr_accessor :current_action, :current_direction, :current_tile, :destination_tile, :health
  attr_reader :input_translator, :armor

  MAX_HEALTH = 20
  BASE_ARMOR = 0

  def initialize
    super

    @health = MAX_HEALTH
    @armor = BASE_ARMOR

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
    @current_action = CharacterAction::DEATH unless health > 0
    super
  end

  # Public: Determines if the Character is playable.
  #
  # Returns a Boolean.
  def playable?
    alive?
  end

  # Public: Determines if the Character is alive.
  #
  # Returns a Boolean.
  def alive?
    health > 0
  end

  # Public: Use a Skill corresponding to the given name.
  #
  # skill_name - Name of the Skill
  #
  # Returns nothing.
  def use_skill!(skill_name)
    skill_class = "Skills::#{skill_name.to_s.camelize}".constantize
    skill_class.new(self, current_tile).execute!
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