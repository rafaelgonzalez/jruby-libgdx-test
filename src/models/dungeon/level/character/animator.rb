class Dungeon::Level::Character
  class LevelCharacterAnimator

    def initialize(level_character)
      @level_character = level_character

      @level_character.screen_x_position = screen_x_position
      @level_character.screen_y_position = screen_y_position
    end

    # Public: Updates the LevelCharacter.
    #
    # Returns nothing.
    def update!
      if @level_character.is_moving?
        if reached_destination_tile?
          @level_character.current_tile = @level_character.destination_tile

          unless @level_character.wants_to_move?
            @level_character.current_action = CharacterAction::STAND

            @level_character.screen_x_position = @level_character.destination_tile.center_x_position.round
            @level_character.screen_y_position = (@level_character.destination_tile.center_y_position + Renderer::CHARACTER_GROUND_OFFSET).round
          end
        end

        update_screen_positions!
      end
    end


    private

    # Internal: Determines if the Character's sprite has reached the destinations tile screen coordinates.
    #
    # Returns a Boolean.
    def reached_destination_tile?
      character_position_y = @level_character.screen_y_position -
                             Renderer::CHARACTER_GROUND_OFFSET

      case @level_character.current_direction
      when Direction::UP
        return character_position_y >= @level_character.destination_tile.center_y_position
      when Direction::DOWN
        return character_position_y <= @level_character.destination_tile.center_y_position
      when Direction::LEFT
        return @level_character.screen_x_position <= @level_character.destination_tile.center_x_position
      when Direction::RIGHT
        return @level_character.screen_x_position >= @level_character.destination_tile.center_x_position
      end
    end

    # Internal: Update the Character's screen positions.
    #
    # Returns nothing.
    def update_screen_positions!
      if [Direction::UP, Direction::DOWN].include? @level_character.current_direction
        @level_character.screen_y_position += (
          Direction.screen_direction(@level_character.current_direction) *
          Renderer::CHARACTER_MOVEMENT_SPEED *
          Gdx.graphics.get_delta_time
        )
      end

      if [Direction::LEFT, Direction::RIGHT].include? @level_character.current_direction
        @level_character.screen_x_position += (
          Direction.screen_direction(@level_character.current_direction) *
          Renderer::CHARACTER_MOVEMENT_SPEED *
          Gdx.graphics.get_delta_time
        )
      end
    end

    def screen_x_position
      (@level_character.x_position * (Dungeon::Level::TILE_WIDTH / 2)) + @level_character.screen_x_position
    end

    def screen_y_position
      (@level_character.y_position * (Dungeon::Level::TILE_HEIGHT / 2)) +
      Renderer::CHARACTER_GROUND_OFFSET +
      @level_character.screen_y_position
    end
  end
end