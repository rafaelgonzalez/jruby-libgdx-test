module KeyBinding
  class Base
    include Input

    def input_action_from_keycode(keycode)
      bindings[keycode]
    end

    def pressed_keys
      bindings.keys.select {|key| Gdx.input.is_key_pressed?(key) }
    end
  end
end