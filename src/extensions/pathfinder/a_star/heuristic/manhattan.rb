module Pathfinder
  class AStar
    module Heuristic
      module Manhattan
        def self.calculate(current, target)
          10 * (
            (current.x_position - target.x_position).abs +
            (current.y_position - target.y_position).abs
          )
        end
      end
    end
  end
end
