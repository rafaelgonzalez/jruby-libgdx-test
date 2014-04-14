module Skills::Move
  class Up < Base
    DIRECTION = Direction::UP

    def initialize(character)
      @direction = DIRECTION
      super(character)
    end
  end
end
