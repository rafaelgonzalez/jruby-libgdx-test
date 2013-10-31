require 'direction'
require 'key_bindings/base'
require 'key_bindings/camera'

class DungeonCrawlCameraInputProcessor < InputAdapter
  DRAG_BUTTON = 1

  attr_reader :camera

  def initialize(camera)
    super()
    @key_bindings ||= KeyBinding::Camera.new
    @camera = camera
  end

  def keyDown(keycode)
    puts "CAMERA KEY DOWN"
    @key_bindings.pressed_keys.each do |keycode|
      if action = @key_bindings.input_action_from_keycode(keycode)
        camera.send(action[0], *action[1])
        return true
      end
    end

    false
  end

  def touchDragged(screen_x, screen_y, pointer)
    if @button == DRAG_BUTTON
      drag_x_translation = @drag_previous_x.nil? ? 0 : (@drag_previous_x - screen_x)
      drag_y_translation = @drag_previous_y.nil? ? 0 : -(@drag_previous_y - screen_y)

      camera.translate(drag_x_translation, drag_y_translation)

      @drag_previous_x = screen_x
      @drag_previous_y = screen_y

      return true
    end

    false
  end

  def touchDown(screen_x, screen_y, pointer, button)
    @button = button
    @drag_previous_x = @drag_previous_y = nil
    true
  end
end