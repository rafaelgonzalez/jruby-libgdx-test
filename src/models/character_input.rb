module CharacterInput
  include Input

  # Public: Transforms the Character according to the given user's input.
  #
  # input - The LwjglInput to analyze.
  #
  # Returns nothing.
  def transform_with_input!(input)
    @current_action = action_from_input(input)
    @current_direction = direction_from_input(input)
    update_screen_positions! if is_moving?
  end


  private

  # Internal: Gets the Character's current action according to the given input.
  #
  # input - The LwjglInput to analyze.
  #
  # Returns a CharacterAction constant.
  def action_from_input(input)
    return CharacterAction::WALK if is_moving?
    return CharacterAction::STAND
  end

  # Internal: Gets the Character's facing direction according to the given input.
  #
  # input - The LwjglInput to analyze.
  #
  # Returns a Direction constant.
  def direction_from_input(input)
    return Direction::UP    if is_key_pressed?(Keys::Z)
    return Direction::DOWN  if is_key_pressed?(Keys::S)
    return Direction::LEFT  if is_key_pressed?(Keys::Q)
    return Direction::RIGHT if is_key_pressed?(Keys::D)
    return @current_direction
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
    one_of_keys_is_pressed?([Keys::Z, Keys::S, Keys::Q, Keys::D])
  end

  # Internal: Determines if one of the given keys is pressed.
  #
  # keys - The Array of Key constants.
  #
  # Returns a Boolean.
  def one_of_keys_is_pressed?(keys)
    keys.each do |key|
      return true if is_key_pressed?(key) == true
    end
    false
  end

  # Internal: Determines if the given key is pressed.
  #
  # key - The Key constant to analyse.
  #
  # Returns a Boolean.
  def is_key_pressed?(key)
    Gdx.input.is_key_pressed(key)
  end
end