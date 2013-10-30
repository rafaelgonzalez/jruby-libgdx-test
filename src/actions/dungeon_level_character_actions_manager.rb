require 'dungeon_action_character_actions/move_to_tile'
require 'dungeon_action_character_actions/finish_move_to_tile'

module DungeonLevelCharacterActionsManager
  # Public: Handles the DungeonLevelCharacterActor's movement sequence to it's destination Tile.
  #
  # Returns nothing.
  def walk_to_next_tile!(direction)
    if !is_moving? and current_tile.has_same_positions_as?(destination_tile)
      tile = fetch_new_destination_tile(direction)

      unless tile.nil?
        @destination_tile = tile
        self.current_direction = direction
        self.current_action = CharacterAction::WALK

        add_action(
          Actions.sequence(
            MoveToTile.new(destination_tile),
            FinishMoveToTile.new
          )
        )
      end
    end
  end


  private

  # Internal: Returns the Tile the DungeonLevelCharacterActor will move to.
  #
  # Returns a Tile or nil if no Tile is found.
  def fetch_new_destination_tile(direction)
    dungeon_level.adjacent_tile_from_direction(current_tile, direction)
  end
end