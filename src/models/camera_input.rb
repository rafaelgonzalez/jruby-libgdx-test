module CameraInput
  include Input

  def transform_with_input!(input)
    update_screen_positions! if is_moving?
    self.update
  end


  private

  def update_screen_positions!
    x_translation = y_translation = 0

    movement = OrthographicCameraExtended::MOVEMENT_SPEED * Gdx.graphics.get_delta_time

    y_translation = movement if is_key_pressed?(Keys::UP)
    y_translation = -movement if is_key_pressed?(Keys::DOWN)
    x_translation = movement if is_key_pressed?(Keys::RIGHT)
    x_translation = -movement if is_key_pressed?(Keys::LEFT)

    self.translate(x_translation, y_translation)
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