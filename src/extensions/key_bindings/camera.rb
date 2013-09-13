module KeyBinding
  class Camera < Base
    BINDINGS = {
      directions: {
        Keys::UP => Direction::DOWN,
        Keys::DOWN => Direction::UP,
        Keys::LEFT => Direction::RIGHT,
        Keys::RIGHT => Direction::LEFT
      }
    }

    def bindings
      BINDINGS
    end
  end
end