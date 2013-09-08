module CharacterInput
  include Input

  # Public: Transforms the Character according to the given user's input.
  #
  # input - The LwjglInput to analyze.
  #
  # Returns nothing.
  def transform_with_input!(input)
    @current_direction = direction_from_input(input)
  end

  private
  # Internal: Gets the proper Characte's facing direction
  # according to the given input.
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

  # Internal: Determines if the given key is pressed.
  #
  # key - The Key constant to analyse.
  #
  # Returns a Boolean.
  def is_key_pressed?(key)
    Gdx.input.is_key_pressed(key)
  end
end