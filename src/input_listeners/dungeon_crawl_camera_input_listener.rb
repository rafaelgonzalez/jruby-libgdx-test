class DungeonCrawlCameraInputListener < InputListener
  def initialize(camera_actor)
    super()
    @camera_actor = camera_actor
  end

  def KeyDown(keycode)
    @key_bindings.pressed_keys.each do |keycode|
      if action = @key_bindings.input_action_from_keycode(keycode)
        send(action[0], *action[1])
      end
    end
  end
end