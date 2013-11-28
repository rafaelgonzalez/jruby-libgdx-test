module KeyBinding
  class Character < Base
    BINDINGS = {
      Keys::W => [:walk_to_next_tile!, [Direction::UP]],
      Keys::S => [:walk_to_next_tile!, [Direction::DOWN]],
      Keys::A => [:walk_to_next_tile!, [Direction::LEFT]],
      Keys::D => [:walk_to_next_tile!, [Direction::RIGHT]]
    }

    CATEGORIES = {
      movement: [Keys::W, Keys::S, Keys::A, Keys::D]
    }

    def bindings
      BINDINGS
    end

    def categories
      CATEGORIES
    end
  end
end