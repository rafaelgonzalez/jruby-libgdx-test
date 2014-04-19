require 'dungeon_crawl_interface'

class DungeonCrawlHudStage < Stage

  attr_reader :map_stage, :hud_interface, :focus_character

  def initialize(map_stage)
    super()

    @map_stage = map_stage
    @hud_interface = DungeonCrawlInterface.new

    self.add_actor(hud_interface)
  end

  def draw
    super

    hud_interface.character_details.set_with_character(map_stage.get_keyboard_focus)
  end
end
