module CameraInput
  include Input

  def transform_with_input!(input)
    update_screen_positions! if is_moving?
    self.update
  end


  private

  def update_screen_positions!
    screen_x_position = screen_y_position = 0

    movement = OrthographicCameraExtended::MOVEMENT_SPEED * Gdx.graphics.get_delta_time

    screen_y_position = movement if is_key_pressed?(Keys::UP)
    screen_y_position = -movement if is_key_pressed?(Keys::DOWN)
    screen_x_position = movement if is_key_pressed?(Keys::RIGHT)
    screen_x_position = -movement if is_key_pressed?(Keys::LEFT)

    self.translate(screen_x_position, screen_y_position)
  end

  # Internal: Determines if the Camera is moving.
  #
  # Returns a Boolean.
  def is_moving?
    one_of_keys_is_pressed?([Keys::UP, Keys::DOWN, Keys::LEFT, Keys::RIGHT])
  end

  def one_of_keys_is_pressed?(keys)
    keys.each do |key|
      return true if is_key_pressed?(key) == true
    end
    false
  end

  def is_key_pressed?(key)
    Gdx.input.is_key_pressed(key)
  end
end