module Pathfinder
  class AStar
    class Node

      attr_reader :tile, :f, :g, :h
      attr_accessor :parent

      def initialize(tile)
        @tile = tile
      end

      def ==(other_node)
        (self.tile.x_position == other_node.tile.x_position) &&
        (self.tile.y_position == other_node.tile.y_position)
      end

      def calculate_scores!(end_node)
        @g = tile.cost + parent.tile.cost
        @h = AStar::Heuristic::Manhattan.calculate(tile, end_node.tile)
        @f = @g + @h
      end
    end
  end
end
