require 'key_bindings/character'

class DungeonLevelCharacterInputListener < InputListener
  def initialize(actor)
    super()
    @key_bindings = KeyBinding::Character.new
    @actor = actor
  end

  def keyDown(input_event, keycode)
    if action = @key_bindings.input_action_from_keycode(keycode)
      @actor.public_send(action[0], *action[1])
      return true
    end

    super
  end
end