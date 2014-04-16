require 'dungeon_crawl_interface'

class DungeonCrawlHudStage < Stage
  def initialize
    super

    self.add_actor(DungeonCrawlInterface.new)
  end
end
