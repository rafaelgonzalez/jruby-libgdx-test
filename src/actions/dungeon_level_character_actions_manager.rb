require 'dungeon_action_character_actions/move_to_tile'
require 'dungeon_action_character_actions/finish_move_to_tile'

module DungeonLevelCharacterActionsManager
  # Public: Handles the DungeonLevelCharacterActor's movement sequence to it's destination Tile.
  #
  # Returns nothing.
  def walk_to_next_tile!(direction)
    if !is_moving? and current_tile.has_same_positions_as?(destination_tile)
      self.current_direction = direction
      self.current_action = CharacterAction::WALK

      set_destination_tile!

      add_action(
        Actions.sequence(
          MoveToTile.new(destination_tile),
          FinishMoveToTile.new
        )
      )
    end
  end


  private

  # Internal: Sets the LevelTile the LevelCharacter will move to.
  #
  # Returns nothing.
  def set_destination_tile!
    destination_tile_x = destination_tile.x_position
    destination_tile_y = destination_tile.y_position

    if [Direction::UP, Direction::DOWN].include? current_direction
      destination_tile_y += Direction.screen_direction(current_direction)
    end

    if [Direction::LEFT, Direction::RIGHT].include? current_direction
      destination_tile_x += Direction.screen_direction(current_direction)
    end

    @destination_tile = Dungeon::Level::Tile.new(destination_tile_x, destination_tile_y)
  end
end