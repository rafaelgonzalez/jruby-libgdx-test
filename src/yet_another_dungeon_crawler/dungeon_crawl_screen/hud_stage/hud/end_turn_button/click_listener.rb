class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class HudStage < Stage
      class Hud < Table
        class EndTurnButton
          class ClickListener < ClickListener
            def clicked(event, x, y)
              event.get_stage.screen.map_stage.dungeon_level_actor.new_turn!
              true
            end
          end
        end
      end
    end
  end
end
