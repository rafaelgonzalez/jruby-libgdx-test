require 'dungeon_crawl_camera_input_processor'

class DungeonCrawlCamera < OrthographicCamera
  MOVEMENT_SPEED = 200

  attr_reader :input_processor

  def initialize
    super
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

  def update
    super
    @input_processor.update
  end

  private

  def translate_from_direction!(direction)
    x_translation = y_translation = 0

    movement = MOVEMENT_SPEED * Gdx.graphics.get_delta_time

    x_translation += movement if direction == Direction::LEFT
    x_translation += -movement if direction == Direction::RIGHT
    y_translation += movement if direction == Direction::DOWN
    y_translation += -movement if direction == Direction::UP

    translate(x_translation, y_translation)
  end
end