module CameraInputTranslator
  def initialize_input
    load_key_bindings
  end

  def transform_from_input!
    update_screen_positions! if is_moving?
    self.update
  end


  private

  def update_screen_positions!
    x_translation = y_translation = 0

    movement = OrthographicCameraExtended::MOVEMENT_SPEED * Gdx.graphics.get_delta_time

    directions = @key_bindings.invoked(:directions)

    y_translation += movement if directions.include?(Direction::DOWN)
    y_translation += -movement if directions.include?(Direction::UP)
    x_translation += movement if directions.include?(Direction::LEFT)
    x_translation += -movement if directions.include?(Direction::RIGHT)

    self.translate(x_translation, y_translation)
  end

  # Internal: Determines if the Camera is moving.
  #
  # Returns a Boolean.
  def is_moving?
    @key_bindings.invoked(:directions).any?
  end

  def load_key_bindings
    @key_bindings = KeyBinding::Camera.new
  end
end