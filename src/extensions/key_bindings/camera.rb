module KeyBinding
  class Camera < Base
    BINDINGS = {
      Keys::UP => [:move_with_direction!, [Yadc::Core::Direction::DOWN]],
      Keys::DOWN => [:move_with_direction!, [Yadc::Core::Direction::UP]],
      Keys::LEFT => [:move_with_direction!, [Yadc::Core::Direction::RIGHT]],
      Keys::RIGHT => [:move_with_direction!, [Yadc::Core::Direction::LEFT]]
    }

    def bindings
      BINDINGS
    end

    def categories
      {}
    end
  end
end
