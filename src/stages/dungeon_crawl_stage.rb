require 'dungeon_crawl_camera'

class DungeonCrawlStage < Stage
  def initialize
    super
    Gdx.input.set_input_processor(self)
    set_camera(DungeonCrawlCamera.new)
  end

  def touchDragged(screen_x, screen_y, pointer)
    drag_x_translation = @drag_previous_x.nil? ? 0 : (@drag_previous_x - screen_x)
    drag_y_translation = @drag_previous_y.nil? ? 0 : -(@drag_previous_y - screen_y)

    get_camera.translate(drag_x_translation, drag_y_translation)

    @drag_previous_x = screen_x
    @drag_previous_y = screen_y

    true
  end

  def touchDown(screen_x, screen_y, pointer, button)
    @drag_previous_x = @drag_previous_y = nil
    super
  end
end