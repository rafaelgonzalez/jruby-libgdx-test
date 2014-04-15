require 'dungeon_crawl_camera'

class DungeonCrawlStage < Stage

  attr_reader :combat_logger

  def initialize
    super
    viewport.set_camera(DungeonCrawlCamera.new)

    @combat_logger = CombatLogger.new
  end

  def draw
    super

    @combat_logger.draw
  end
end
