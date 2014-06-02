require_relative 'a_star/heuristic'
require_relative 'a_star/node'

module Pathfinder
  class AStar

    attr_reader :closed_list, :open_list, :start_node, :end_node, :current_node, :path

    def initialize(start_tile, end_tile)
      @open_list = []
      @closed_list = []
      @path = []

      @start_node = Node.new(start_tile)
      @end_node = Node.new(end_tile)
    end

    def find_path!
      @open_list = []
      @closed_list = []
      @path = []

      @current_node = start_node
      open_list.push(start_node)

      until closed_list.include?(end_node) or open_list.empty? do
        current_node.tile.walkable_neighbours.each do |neighbour_tile|
          handle_neighbour(Node.new(neighbour_tile))
        end

        closed_list.push(open_list.delete(current_node))

        @current_node = open_list.sort_by{ |node| node.f }.first
      end

      build_path
    end

    private

    def handle_neighbour(node)
      return if closed_list.include?(node)

      # TODO: Simple hack, but needs to be cleaned up
      node = end_node if node == end_node

      if open_list.include?(node)
        if node.g.nil? or ((current_node.tile.cost + node.tile.cost) < node.g)
          node.parent = current_node
          node.calculate_scores!(end_node)
        end
      else
        node.parent = current_node
        node.calculate_scores!(end_node)
        open_list.push(node)
      end
    end

    def build_path
      if open_list.empty?
        @path = []
      else
        node = end_node

        until node == start_node do
          path.push(node.tile)
          node = node.parent
        end

        path.push(start_node.tile)
        path.reverse!
      end

      return path
    end
  end
end
