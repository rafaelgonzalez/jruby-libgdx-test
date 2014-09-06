module Yadc
  module Core
    module Skills
      module Move
        class Base < Skills::Base

          attr_reader :character, :direction

          COSTS = {
            action_points: 1
          }

          def initialize(character)
            unless direction
              raise RuntimeError.new('Child class must set @direction instance variable.')
            end

            @character = character
          end

          def destination_tile
            return nil unless character.current_tile
            character.current_tile.adjacent_tile(direction)
          end

          # Public: Handles the character's movement sequence to it's destination Tile.
          #
          # Returns nothing.
          def execute!
            if resources_available? and can_move_to_destination?
              spend_resources!

              character.current_tile = destination_tile
              character.destination_tile = destination_tile
              character.current_direction = direction

            elsif resources_available? and !can_move_to_destination?  and character.current_direction != direction
              spend_resources!

              character.current_direction = direction
            end
          end

          def costs
            COSTS
          end

          def can_move_to_destination?
            !destination_tile.nil? and destination_tile.walkable?
          end
        end
      end
    end
  end
end
