module KeyBinding
  class Camera < Base
    BINDINGS = {
      Keys::UP => [:move_with_direction!, [Direction::DOWN]],
      Keys::DOWN => [:move_with_direction!, [Direction::UP]],
      Keys::LEFT => [:move_with_direction!, [Direction::RIGHT]],
      Keys::RIGHT => [:move_with_direction!, [Direction::LEFT]]
    }

    def bindings
      BINDINGS
    end

    def categories
      {}
    end
  end
end
