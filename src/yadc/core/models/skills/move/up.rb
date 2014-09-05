module Yadc
  module Core
    module Skills
      module Move
        class Up < Base
          DIRECTION = Direction::UP

          def initialize(character)
            @direction = DIRECTION
            super(character)
          end
        end
      end
    end
  end
end
