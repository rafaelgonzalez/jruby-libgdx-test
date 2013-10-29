require 'dungeon_crawl_camera'

class DungeonCrawlStage < Stage
  def initialize
    super
    Gdx.input.set_input_processor(self)
    set_camera(DungeonCrawlCamera.new)
  end
end