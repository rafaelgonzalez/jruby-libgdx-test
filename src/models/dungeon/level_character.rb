module Dungeon
  class LevelCharacter

    def initialize(level, character, x_position, y_position)
      @level = level
      @character = character
      @x_position = x_position
      @y_position = y_position

      @character.screen_x_position = screen_x_position
      @character.screen_y_position = screen_y_position
    end

    def render(state_time, camera)
      @character.draw(state_time, camera)
    end


    private

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