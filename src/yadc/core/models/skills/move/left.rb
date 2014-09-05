module Yadc
  module Core
    module Skills
      module Move
        class Left < Base
          DIRECTION = Direction::LEFT

          def initialize(character)
            @direction = DIRECTION
            super(character)
          end
        end
      end
    end
  end
end
