module Dungeon
  class LevelCharacter

    def initialize(level, character, x_position, y_position)
      @level = level
      @character = character
      @x_position = x_position
      @y_position = y_position
    end

    def render(state_time, camera)
      @character.draw(state_time, camera)
    end
  end
end