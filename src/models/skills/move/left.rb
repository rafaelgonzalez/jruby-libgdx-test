module Skills::Move
  class Left < Base
    DIRECTION = Direction::LEFT

    def initialize(character)
      @direction = DIRECTION
      super(character)
    end
  end
end
