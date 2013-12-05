module Skills::Move
  class Left < Base
    DIRECTION = Direction::LEFT

    def initialize(owner, origin_tile)
      @direction = DIRECTION
      super(owner, origin_tile)
    end
  end
end