require 'dungeon_crawl_camera_input_processor'

class DungeonCrawlCamera < OrthographicCamera
  LERP_ALPHA_SMOOTH = 0.3

  MINIMUM_ZOOM_LIMIT = 0
  MAXIMUM_ZOOM_LIMIT = 2

  attr_reader :input_processor

  def initialize
    super
    @destination_vector = nil
    @input_processor = DungeonCrawlCameraInputProcessor.new(self)
  end

  # Public: Makes the camera move smoothly to the given coordinates.
  #
  # screen_x - The horizontal coordinate to move the Camera to.
  # screen_y - The vertical coordinate to move the Camera to.
  #
  # Returns nothing.
  def move_to!(screen_x, screen_y)
    @destination_vector = Vector3.new(screen_x, screen_y, position.z)
    @destination_distance = @destination_vector.dst2(position)
  end

  # Public: Sets all movement related variables to nil, in order to cancel all current camera movements.
  #
  # Returns nothing.
  def terminate_current_movement!
    @destination_vector = nil
    @destination_distance = nil
  end

  def change_zoom(amount)
    unless exceeds_zoom_limits?(amount)
      self.zoom += amount
      return true
    end

    false
  end

  def update
    super
    update_camera_position!
    @input_processor.update
  end


  private

  # Internal: Porvides abrstraction for #move_to!, by simply passing a direction.
  #
  # direction - A Direction constant.
  #
  # Returns nothing.
  def move_with_direction!(direction)
    new_screen_x = position.x
    new_screen_y = position.y

    new_screen_x += 64 if direction == Direction::LEFT
    new_screen_x += -64 if direction == Direction::RIGHT
    new_screen_y += 64 if direction == Direction::DOWN
    new_screen_y += -64 if direction == Direction::UP

    move_to!(new_screen_x, new_screen_y)
  end

  # Internal: Update the camera's position, if needed.
  #
  # Returns nothing.
  def update_camera_position!
    return unless @destination_vector and @destination_distance
    alpha = (@destination_distance - @destination_vector.dst2(position)) / @destination_distance
    alpha = LERP_ALPHA_SMOOTH if alpha == 0.0
    position.lerp(@destination_vector, alpha * LERP_ALPHA_SMOOTH)
    terminate_current_movement! if alpha.round(2) == 1.0
  end

  def exceeds_zoom_limits?(amount)
    total_amount = self.zoom + amount

    return true if (total_amount <= MINIMUM_ZOOM_LIMIT) or (total_amount >= MAXIMUM_ZOOM_LIMIT)
    false
  end
end
