module Yadc
  module Core
    module Skills
      module Move
        module Actions
          class MoveToTile < MoveToAction
            def initialize(actor, destination_tile)
              super()

              set_x actor.screen_x_position(destination_tile)
              set_y actor.screen_y_position(destination_tile)

              set_duration(0.5)
            end
          end
        end
      end
    end
  end
end
