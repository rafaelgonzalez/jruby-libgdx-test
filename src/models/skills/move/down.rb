module Skills::Move
  class Down < Base
    DIRECTION = Direction::DOWN

    def initialize(owner, origin_tile)
      @direction = DIRECTION
      super(owner, origin_tile)
    end
  end
end