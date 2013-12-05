module Skills::Move
  class Right < Base
    DIRECTION = Direction::RIGHT

    def initialize(owner, origin_tile)
      @direction = DIRECTION
      super(owner, origin_tile)
    end
  end
end