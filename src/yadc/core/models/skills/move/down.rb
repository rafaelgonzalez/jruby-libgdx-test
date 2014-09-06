module Yadc
  module Core
    module Skills
      module Move
        class Down < Base
          DIRECTION = Direction::DOWN

          def initialize(character)
            @direction = DIRECTION
            super(character)
          end
        end
      end
    end
  end
end
