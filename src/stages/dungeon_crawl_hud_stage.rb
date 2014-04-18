require 'dungeon_crawl_interface'

class DungeonCrawlHudStage < Stage

  attr_reader :map_stage, :hud_interface, :focus_character

  def initialize(map_stage)
    super()

    @map_stage = map_stage
    @hud_interface = DungeonCrawlInterface.new
    @focus_character = nil

    self.add_actor(hud_interface)
  end

  def draw
    super

    hud_interface.set_character_details(map_stage.get_keyboard_focus)
  end
end
