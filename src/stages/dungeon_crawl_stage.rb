require 'dungeon_crawl_camera'

class DungeonCrawlStage < Stage
  def initialize
    super
    Gdx.input.set_input_processor(self)
    set_camera(DungeonCrawlCamera.new)
  end

  def touchDragged(screen_x, screen_y, pointer)
    get_camera.touchDragged(screen_x, screen_y, pointer) || super
  end

  def touchDown(screen_x, screen_y, pointer, button)
    get_camera.touchDown(screen_x, screen_y, pointer, button)
    super
  end
end