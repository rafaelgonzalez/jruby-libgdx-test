module KeyBinding
  class Character < Base
    BINDINGS = {
      directions: {
        Keys::W => Direction::UP,
        Keys::S => Direction::DOWN,
        Keys::A => Direction::LEFT,
        Keys::D => Direction::RIGHT
      }
    }

    def bindings
      BINDINGS
    end
  end
end