module Yadc
  module Core
    module Pathfinder
      class AStar
        class Node

          attr_reader :tile, :f, :g, :h
          attr_accessor :parent

          def initialize(tile)
            @tile = tile
          end

          def ==(other_node)
            self.tile == other_node.tile
          end

          def calculate_scores!(end_node)
            return unless parent
            @g = tile.cost + parent.tile.cost
            @h = AStar::Heuristic::Manhattan.calculate(tile.x_position,
                                                       tile.y_position,
                                                       end_node.tile.x_position,
                                                       end_node.tile.y_position)
            @f = @g + @h
          end
        end
      end
    end
  end
end
