require_relative 'actions/finish_move_to_tile'
require_relative 'actions/move_to_tile'

module Skills::Move
  class Base

    attr_reader :character, :direction, :destination_tile

    def initialize(character, origin_tile)
      unless @direction
        raise RuntimeError.new('Child class must set @direction instance variable.')
      end

      @character = character
      @destination_tile = origin_tile.adjacent_tile(direction)
    end

    # Public: Handles the character's movement sequence to it's destination Tile.
    #
    # Returns nothing.
    def execute!
      character.actor.nil? ? move_character : move_character_actor
    end

    private

    def move_character
      if !destination_tile.nil? and destination_tile.walkable?
        character.current_tile = destination_tile
        character.current_direction = direction
      end
    end

    def move_character_actor
      unless character.actor.is_moving?
        if !destination_tile.nil? and destination_tile.walkable?
          character.destination_tile = destination_tile
          character.current_direction = direction
          character.actor.current_action = CharacterAction::WALK

          character.actor.add_action(
            ::Actions.sequence(
              Actions::MoveToTile.new(destination_tile),
              Actions::FinishMoveToTile.new
            )
          )
        else
          character.current_direction = direction
        end
      end
    end
  end
end
