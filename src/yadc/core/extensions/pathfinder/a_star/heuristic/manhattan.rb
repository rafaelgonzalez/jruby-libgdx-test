module Yadc
  module Core
    module Pathfinder
      class AStar
        module Heuristic
          module Manhattan
            def self.calculate(current_x, current_y, target_x, target_y)
              10 * ((current_x - target_x).abs + (current_y - target_y).abs)
            end
          end
        end
      end
    end
  end
end
