module KeyBinding
  class Base
    include Input

    def invoked(category)
      pressed_keys(category).collect {|key| bindings[category][key] }
    end

    private
    def pressed_keys(category)
      bindings[category].keys.select {|key| input.is_key_pressed?(key) }
    end

    def input
      Gdx.input
    end
  end
end