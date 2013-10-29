module KeyBinding
  class Camera < Base
    BINDINGS = {
      Keys::UP => [:translate_from_direction!, [Direction::DOWN]],
      Keys::DOWN => [:translate_from_direction!, [Direction::UP]],
      Keys::LEFT => [:translate_from_direction!, [Direction::RIGHT]],
      Keys::RIGHT => [:translate_from_direction!, [Direction::LEFT]]
    }

    def bindings
      BINDINGS
    end
  end
end