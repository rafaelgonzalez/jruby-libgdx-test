class DungeonCrawlCamera < OrthographicCamera
  MOVEMENT_SPEED = 200

  def initialize
    super
    @key_bindings ||= KeyBinding::Camera.new
  end

  def update
    @key_bindings.pressed_keys.each do |keycode|
      if action = @key_bindings.input_action_from_keycode(keycode)
        send(action[0], *action[1])
      end
    end

    super
  end

  private

  def translate_from_direction!(direction)
    x_translation = y_translation = 0

    movement = MOVEMENT_SPEED * Gdx.graphics.get_delta_time

    x_translation += movement if direction == Direction::LEFT
    x_translation += -movement if direction == Direction::RIGHT
    y_translation += movement if direction == Direction::DOWN
    y_translation += -movement if direction == Direction::UP

    self.translate(x_translation, y_translation)
  end
end