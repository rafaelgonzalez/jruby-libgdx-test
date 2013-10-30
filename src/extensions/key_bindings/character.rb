module KeyBinding
  class Character < Base
    BINDINGS = {
      Keys::W => [:walk_to_next_tile!, [Direction::UP]],
      Keys::S => [:walk_to_next_tile!, [Direction::DOWN]],
      Keys::A => [:walk_to_next_tile!, [Direction::LEFT]],
      Keys::D => [:walk_to_next_tile!, [Direction::RIGHT]]
    }

    def bindings
      BINDINGS
    end
  end
end