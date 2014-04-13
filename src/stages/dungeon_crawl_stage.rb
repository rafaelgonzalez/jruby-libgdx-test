require 'dungeon_crawl_camera'

class DungeonCrawlStage < Stage
  def initialize
    super
    viewport.set_camera(DungeonCrawlCamera.new)
  end
end
