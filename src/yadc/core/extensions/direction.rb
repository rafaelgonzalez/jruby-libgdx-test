module Yadc
  module Core
    module Direction
      UP = 1
      LEFT = 2
      DOWN = 3
      RIGHT = 4

      def self.screen_direction(direction)
        return 1 if [UP, RIGHT].include? direction
        return -1 if [DOWN, LEFT].include? direction
      end
    end
  end
end
