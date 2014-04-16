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
    @callbacks = []
  end

  def update
    @callbacks.each do |method_name, arguments|
      camera.send(method_name, *arguments)
    end
  end

  def keyDown(keycode)
    if callback = @key_bindings.input_action_from_keycode(keycode)
      unless @callbacks.include?(callback)
        @callbacks.push(callback)
        return true
      end
    end

    false
  end

  def keyUp(keycode)
    if callback = @key_bindings.input_action_from_keycode(keycode)
      if @callbacks.include?(callback)
        @callbacks.delete(callback)
        return true
      end
    end

    false
  end

  def scrolled(amount)
    camera.change_zoom(amount / 10.0)
  end

  def touchDragged(screen_x, screen_y, pointer)
    if @button == DRAG_BUTTON
      camera.terminate_current_movement!

      drag_x_translation = @drag_previous_x.nil? ? 0 : ((@drag_previous_x - screen_x) * camera.zoom)
      drag_y_translation = @drag_previous_y.nil? ? 0 : (-(@drag_previous_y - screen_y) * camera.zoom)

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
