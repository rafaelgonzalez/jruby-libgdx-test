module Skills::Move
  class Up < Base
    DIRECTION = Direction::UP

    def initialize(owner, origin_tile)
      @direction = DIRECTION
      super(owner, origin_tile)
    end
  end
end