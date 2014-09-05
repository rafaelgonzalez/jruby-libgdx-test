require 'yadc/core/models/direction'

require_relative 'actions/finish_move_to_tile'
require_relative 'actions/move_to_tile'

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
            return false if character.actor.is_moving?

            if resources_available? and can_move_to_destination?
              spend_resources!

              character.destination_tile = destination_tile
              character.current_direction = direction
              character.actor.current_action = Character::Action::WALK

              character.actor.add_action(
                ::Actions.sequence(
                  Actions::MoveToTile.new(character.actor, destination_tile),
                  Actions::FinishMoveToTile.new
                )
              )

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
