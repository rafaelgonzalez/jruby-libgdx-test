module Yadc
  module Core
    class Dungeon
      class Level
        class Tile

          attr_reader :x_position, :y_position, :dungeon_level
          attr_accessor :character, :cost

          def initialize(x_position, y_position, cost, dungeon_level)
            @x_position = x_position
            @y_position = y_position
            @cost = cost
            @dungeon_level = dungeon_level
            @character = nil
          end

          # Public: Determines if this Tile can be walked.
          #
          # Returns a Boolean.
          def walkable?
            !difficulty_impossible? and empty?
          end

          def neighbours
            [
              adjacent_tile(Direction::RIGHT),
              adjacent_tile(Direction::LEFT),
              adjacent_tile(Direction::UP),
              adjacent_tile(Direction::DOWN)
            ].compact
          end

          def walkable_neighbours
            neighbours.select do |tile|
              tile.walkable?
            end
          end

          def difficulty_impossible?
            cost == false
          end

          def empty?
            !@character
          end

          # Public: Get the Tile adjacent to this Tile in the given direction.
          #
          # direction  - A Direction constant.
          #
          # Returns a Tile or nil if no Tile is found.
          def adjacent_tile(direction)
            destination_tile_x = x_position
            destination_tile_y = y_position

            if [Direction::UP, Direction::DOWN].include? direction
              destination_tile_y += Direction.screen_direction(direction)
            end

            if [Direction::LEFT, Direction::RIGHT].include? direction
              destination_tile_x += Direction.screen_direction(direction)
            end

            dungeon_level.tile(destination_tile_x, destination_tile_y)
          end
        end
      end
    end
  end
end
