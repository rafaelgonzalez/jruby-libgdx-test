require 'dungeon_crawl_camera_input_processor'

class DungeonCrawlCamera < OrthographicCamera
  LERP_ALPHA_SMOOTH = 0.3

  attr_reader :input_processor

  def initialize
    super
    @destination_vector = nil
    @input_processor = DungeonCrawlCameraInputProcessor.new(self)
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

  def terminate_current_movement!
    @destination_vector = nil
  end

  def update
    super
    update_camera_focus!
    @input_processor.update
  end


  private

  def move_with_direction!(direction)
    new_screen_x = position.x
    new_screen_y = position.y

    new_screen_x += 64 if direction == Direction::LEFT
    new_screen_x += -64 if direction == Direction::RIGHT
    new_screen_y += 64 if direction == Direction::DOWN
    new_screen_y += -64 if direction == Direction::UP

    move_to!(new_screen_x, new_screen_y)
  end

  def update_camera_focus!
    return unless @destination_vector
    alpha = (@destination_distance - @destination_vector.dst2(position)) / @destination_distance
    alpha = LERP_ALPHA_SMOOTH if alpha == 0.0
    position.lerp(@destination_vector, alpha * LERP_ALPHA_SMOOTH)
    terminate_current_movement! if alpha.round(2) == 1.0
  end
end