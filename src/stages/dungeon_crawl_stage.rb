require 'dungeon_crawl_camera'

class DungeonCrawlStage < Stage
  def initialize
    super
    set_camera(DungeonCrawlCamera.new)
  end
end