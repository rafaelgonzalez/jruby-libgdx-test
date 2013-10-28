require 'key_bindings/character'

class DungeonLevelCharacterInputListener < InputListener
  def initialize(actor)
    super()
    @key_bindings = KeyBinding::Character.new
    @actor = actor
  end

  def keyDown(input_event, keycode)
    if @key_bindings.invoked(:directions).any?
      @actor.walk_to_next_tile! @key_bindings.invoked(:directions).first
    end

    true
  end
end