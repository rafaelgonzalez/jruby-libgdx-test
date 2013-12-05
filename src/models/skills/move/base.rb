require_relative 'actions/finish_move_to_tile'
require_relative 'actions/move_to_tile'

module Skills::Move
  class Base

    attr_reader :owner, :origin_tile, :direction, :destination_tile

    def initialize(owner, origin_tile)
      unless @direction
        raise RuntimeError.new('Child class must set @direction instance variable.')
      end

      @owner = owner
      @origin_tile = origin_tile
      @destination_tile = origin_tile.adjacent_tile(direction)
    end

    # Public: Handles the owner's movement sequence to it's destination Tile.
    #
    # Returns nothing.
    def execute!
      unless owner.is_moving?
        if !destination_tile.nil? and destination_tile.walkable?
          owner.destination_tile = destination_tile
          owner.current_direction = direction
          owner.current_action = CharacterAction::WALK

          owner.add_action(
            ::Actions.sequence(
              Actions::MoveToTile.new(destination_tile),
              Actions::FinishMoveToTile.new
            )
          )
        end
      end
    end

  end
end