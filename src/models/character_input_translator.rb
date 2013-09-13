module CharacterInputTranslator
  def initialize_input
    load_key_bindings
  end

  # Public: Transforms the Character according to the given user's input.
  #
  # Returns nothing.
  def transform_from_input!
    @current_action = action_from_input
    @current_direction = direction_from_input
    update_screen_positions! if is_moving?
  end


  private

  # Internal: Gets the Character's current action according to the given input.
  #
  # Returns a CharacterAction constant.
  def action_from_input
    return CharacterAction::WALK if is_moving?
    return CharacterAction::STAND
  end

  # Internal: Gets the Character's facing direction according to the given input.
  #
  # Returns a Direction constant.
  def direction_from_input
    if @key_bindings.invoked(:directions).any?
      return @key_bindings.invoked(:directions).first
    else
      return @current_direction
    end
  end

  # Internal: Update the Character's screen positions.
  #
  # Returns nothing.
  def update_screen_positions!
    if [Direction::UP, Direction::DOWN].include? @current_direction
      @screen_y_position += (
        Direction.screen_direction(@current_direction) *
        CharacterRenderer::CHARACTER_MOVEMENT_SPEED *
        Gdx.graphics.get_delta_time
      )
    end

    if [Direction::LEFT, Direction::RIGHT].include? @current_direction
      @screen_x_position += (
        Direction.screen_direction(@current_direction) *
        CharacterRenderer::CHARACTER_MOVEMENT_SPEED *
        Gdx.graphics.get_delta_time
      )
    end
  end

  # Internal: Determines if the Character is moving.
  #
  # Returns a Boolean.
  def is_moving?
    @key_bindings.invoked(:directions).any?
  end

  def load_key_bindings
    @key_bindings = KeyBinding::Character.new
  end
end