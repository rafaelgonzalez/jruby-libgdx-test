require_relative 'actions/finish_move_to_tile'
require_relative 'actions/move_to_tile'

module Skills
  module Move
    class Base < Skills::Base

      attr_reader :character, :direction, :destination_tile

      RESOURCE = :stamina
      COST = 1

      def initialize(character)
        unless direction
          raise RuntimeError.new('Child class must set @direction instance variable.')
        end

        @character = character
        @destination_tile = character.current_tile.adjacent_tile(direction)
      end

      # Public: Handles the character's movement sequence to it's destination Tile.
      #
      # Returns nothing.
      def execute!
        character.actor.nil? ? move_character : move_character_actor
      end

      def resource
        RESOURCE
      end

      def cost
        COST
      end

      def can_move_to_destination?
        !destination_tile.nil? and destination_tile.walkable?
      end

      private

      def move_character
        if resource_available? and can_move_to_destination?
          spend!

          character.current_tile = destination_tile
          character.current_direction = direction

        elsif resource_available? and !can_move_to_destination?
          spend!

          character.current_direction = direction
        end
      end

      def move_character_actor
        return false if character.actor.is_moving?

        if resource_available? and can_move_to_destination?
          spend!

          character.destination_tile = destination_tile
          character.current_direction = direction
          character.actor.current_action = CharacterAction::WALK

          character.actor.add_action(
            ::Actions.sequence(
              Actions::MoveToTile.new(destination_tile),
              Actions::FinishMoveToTile.new
            )
          )

        elsif resource_available? and !can_move_to_destination?
          spend!

          character.current_direction = direction
        end
      end
    end
  end
end
