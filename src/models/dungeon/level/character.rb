class Dungeon::Level
  class Character

    attr_reader :character, :destination_tile, :x_position, :y_position
    attr_accessor :current_tile

    def initialize(character, x_position, y_position)
      @character = character

      @current_tile = Tile.new(x_position, y_position)
      @destination_tile = Tile.new(x_position, y_position)

      @animator = LevelCharacterAnimator.new(self)
    end

    # Public: Updates and renders the LevelCharacter.
    #
    # Returns nothing.
    def render(state_time, camera)
      update!
      @animator.update!
      @character.draw(state_time, camera)
    end

    def x_position
      @current_tile.x_position
    end

    def y_position
      @current_tile.y_position
    end

    private

    # Internal: Updates the LevelCharacter.
    #
    # Returns nothing.
    def update!
      if @character.is_moving?
        set_destination_tile! if @current_tile.has_same_positions_as?(@destination_tile)
      end
    end

    # Internal: Sets the LevelTile the LevelCharacter will move to.
    #
    # Returns nothing.
    def set_destination_tile!
      destination_tile_x = @destination_tile.x_position
      destination_tile_y = @destination_tile.y_position

      if [Direction::UP, Direction::DOWN].include? @character.current_direction
        destination_tile_y += Direction.screen_direction(@character.current_direction)
      end

      if [Direction::LEFT, Direction::RIGHT].include? @character.current_direction
        destination_tile_x += Direction.screen_direction(@character.current_direction)
      end

      @destination_tile = Tile.new(destination_tile_x, destination_tile_y)
    end
  end
end