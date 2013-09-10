module KeyBinding
  class Character < Base
    BINDINGS = {
      directions: {
        Keys::Z => Direction::UP,
        Keys::S => Direction::DOWN,
        Keys::Q => Direction::LEFT,
        Keys::D => Direction::RIGHT
      }
    }

    def bindings
      BINDINGS
    end
  end
end