module KeyBinding
  class Base
    include Input

    def input_action_from_keycode(keycode)
      bindings[keycode]
    end
  end
end