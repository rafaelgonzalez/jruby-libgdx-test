require 'dungeon_crawl_camera_input_processor'

class DungeonCrawlCamera < OrthographicCamera
  KEY_DOWN_MOVEMENT_SPEED = 500
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

  def translate_from_direction!(direction)
    x_translation = y_translation = 0

    movement = KEY_DOWN_MOVEMENT_SPEED * Gdx.graphics.get_delta_time

    x_translation += movement if direction == Direction::LEFT
    x_translation += -movement if direction == Direction::RIGHT
    y_translation += movement if direction == Direction::DOWN
    y_translation += -movement if direction == Direction::UP

    translate(x_translation, y_translation)
  end

  def update_camera_focus!
    return unless @destination_vector
    alpha = (@destination_distance - @destination_vector.dst2(position)) / @destination_distance
    alpha = LERP_ALPHA_SMOOTH if alpha == 0.0
    position.lerp(@destination_vector, alpha * LERP_ALPHA_SMOOTH)
    terminate_current_movement! if alpha.round(2) == 1.0
  end
end