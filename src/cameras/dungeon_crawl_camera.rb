class DungeonCrawlCamera < OrthographicCamera
  MOVEMENT_SPEED = 200
  DRAG_BUTTON = 1

  def initialize
    super
    @key_bindings ||= KeyBinding::Camera.new
  end

  # Public: Makes the camera move immediately to the given coordinates.
  #
  # screen_x - The horizontal coordinate to move the Camera to.
  # screen_y - The vertical coordinate to move the Camera to.
  #
  # Returns nothing.
  def snap_to!(screen_x, screen_y)
    position.x = screen_x
    position.y = screen_y
  end

  def update
    @key_bindings.pressed_keys.each do |keycode|
      if action = @key_bindings.input_action_from_keycode(keycode)
        send(action[0], *action[1])
      end
    end

    super
  end

  def touchDragged(screen_x, screen_y, pointer)
    if @button == DRAG_BUTTON
      drag_x_translation = @drag_previous_x.nil? ? 0 : (@drag_previous_x - screen_x)
      drag_y_translation = @drag_previous_y.nil? ? 0 : -(@drag_previous_y - screen_y)

      translate(drag_x_translation, drag_y_translation)

      @drag_previous_x = screen_x
      @drag_previous_y = screen_y

      return true
    end

    false
  end

  def touchDown(screen_x, screen_y, pointer, button)
    @button = button
    @drag_previous_x = @drag_previous_y = nil
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