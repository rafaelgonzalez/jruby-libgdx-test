module KeyBinding
  class Base
    include Input

    def input_action_from_keycode(keycode)
      bindings[keycode]
    end

    def pressed_keys
      bindings.keys.select {|key| Gdx.input.is_key_pressed?(key) }
    end

    # Public: Returns all the callbacks of the pressed keys within the given category.
    #
    # category_name - The name of the category.
    #
    # Returns an Array.
    def pressed_category_callbacks(category_name)
      if category_pressed?(category_name)
        pressed_keys = categories[category_name].select {|key| Gdx.input.is_key_pressed(key) }
        pressed_keys.collect {|key| input_action_from_keycode(key) }
      else
        []
      end
    end

    # Public: Determines if any key binding in the given category is pressed.
    #
    # category_name - The name of the category.
    #
    # Returns a Boolean.
    def category_pressed?(category_name)
      return false unless categories[category_name]
      categories[category_name].any? {|key| pressed_keys.include? key }
    end
  end
end