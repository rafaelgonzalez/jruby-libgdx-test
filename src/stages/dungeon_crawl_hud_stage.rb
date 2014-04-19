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

    set_character_details_from_keyboard_focus
  end

  def set_character_details_from_keyboard_focus
    if map_stage.get_keyboard_focus.is_a?(DungeonLevelCharacterActor)
      unless hud_interface.character_details.table.is_visible
        hud_interface.character_details.table.set_visible(true)
      end

      hud_interface.character_details.set_with_character(map_stage.get_keyboard_focus)
    else
      hud_interface.character_details.table.set_visible(false)
    end
  end
end
