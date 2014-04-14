module Skills::Move
  class Right < Base
    DIRECTION = Direction::RIGHT

    def initialize(character)
      @direction = DIRECTION
      super(character)
    end
  end
end
