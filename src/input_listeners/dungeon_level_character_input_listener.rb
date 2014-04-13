require 'direction'
require 'key_bindings/base'
require 'key_bindings/character'

class DungeonLevelCharacterInputListener < InputListener
  def initialize(actor)
    super()
    @key_bindings = KeyBinding::Character.new
    @actor = actor
  end

  def keyDown(input_event, keycode)
    return false unless @actor.playable?

    if action = @key_bindings.input_action_from_keycode(keycode)
      @actor.public_send(action[0], *action[1])
      return true
    end

    false
  end
end
