module Dungeon
  class LevelCharacter

    def initialize(level, character, x_position, y_position)
      @level = level
      @character = character
      @x_position = x_position
      @y_position = y_position

      @current_tile = LevelTile.new(x_position, y_position)
      @destination_tile = LevelTile.new(x_position, y_position)

      @character.screen_x_position = screen_x_position
      @character.screen_y_position = screen_y_position
    end

    def render(state_time, camera)
      update!
      @character.draw(state_time, camera)
    end


    private

    def update!
      if @character.is_moving?
        set_destination_tile! if @current_tile.has_same_positions_as?(@destination_tile)

        if reached_destination_tile?
          @current_tile = @destination_tile

          unless @character.wants_to_move?
            @character.current_action = CharacterAction::STAND

            @character.screen_x_position = @destination_tile.center_x_position.round
            @character.screen_y_position = (@destination_tile.center_y_position + CharacterRenderer::CHARACTER_GROUND_OFFSET).round
          end
        end

        update_screen_positions!
      end
    end

    def reached_destination_tile?
      character_position_y = @character.screen_y_position - CharacterRenderer::CHARACTER_GROUND_OFFSET

      case @character.current_direction
      when Direction::UP
        return character_position_y >= @destination_tile.center_y_position
      when Direction::DOWN
        return character_position_y <= @destination_tile.center_y_position
      when Direction::LEFT
        return @character.screen_x_position <= @destination_tile.center_x_position
      when Direction::RIGHT
        return @character.screen_x_position >= @destination_tile.center_x_position
      end
    end

    def set_destination_tile!
      destination_tile_x = @destination_tile.x_position
      destination_tile_y = @destination_tile.y_position

      if [Direction::UP, Direction::DOWN].include? @character.current_direction
        destination_tile_y += Direction.screen_direction(@character.current_direction)
      end

      if [Direction::LEFT, Direction::RIGHT].include? @character.current_direction
        destination_tile_x += Direction.screen_direction(@character.current_direction)
      end

      @destination_tile = LevelTile.new(destination_tile_x, destination_tile_y)
    end

    # Internal: Update the Character's screen positions.
    #
    # Returns nothing.
    def update_screen_positions!
      if [Direction::UP, Direction::DOWN].include? @character.current_direction
        @character.screen_y_position += (
          Direction.screen_direction(@character.current_direction) *
          CharacterRenderer::CHARACTER_MOVEMENT_SPEED *
          Gdx.graphics.get_delta_time
        )
      end

      if [Direction::LEFT, Direction::RIGHT].include? @character.current_direction
        @character.screen_x_position += (
          Direction.screen_direction(@character.current_direction) *
          CharacterRenderer::CHARACTER_MOVEMENT_SPEED *
          Gdx.graphics.get_delta_time
        )
      end
    end

    def screen_x_position
      (@x_position * (Dungeon::Level::TILE_WIDTH / 2)) + @character.screen_x_position
    end

    def screen_y_position
      (@y_position * (Dungeon::Level::TILE_HEIGHT / 2)) +
      CharacterRenderer::CHARACTER_GROUND_OFFSET +
      @character.screen_y_position
    end
  end
end