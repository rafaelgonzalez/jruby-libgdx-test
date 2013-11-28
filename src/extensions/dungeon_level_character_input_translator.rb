require 'key_bindings/base'
require 'key_bindings/character'

class DungeonLevelCharacterInputTranslator
  include Input

  def initialize(actor)
    @actor = actor
    @key_bindings = KeyBinding::Character.new
  end

  # Public: Get the currently desired movement direction for the Character
  #
  # Returns a Direction constant, or nil if Character does not want to move.
  def movement_direction
    if wants_to_move?
      if Gdx.input.is_key_pressed(Keys::W)
        Direction::UP
      elsif Gdx.input.is_key_pressed(Keys::A)
        Direction::LEFT
      elsif Gdx.input.is_key_pressed(Keys::S)
        Direction::DOWN
      elsif Gdx.input.is_key_pressed(Keys::D)
        Direction::RIGHT
      end
    else
      nil
    end
  end

  private

  def wants_to_move?
    if has_keyboard_focus?
      @key_bindings.bindings.keys.any? {|key| Gdx.input.is_key_pressed(key) }
    else
      false
    end
  end

  # Public: Determines if the Character currently has the keyboard focus.
  #
  # Returns a Boolean.
  def has_keyboard_focus?
    @actor == @actor.get_stage.get_keyboard_focus
  end
end