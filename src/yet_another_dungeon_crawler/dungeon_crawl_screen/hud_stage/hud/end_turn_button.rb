class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class HudStage < Stage
      class Hud < Table
        class EndTurnButton

          attr_reader :button

          def initialize(skin)
            @button = TextButton.new('END TURN', skin)
            button.add_listener(EndTurnButtonClickListener.new(Input::Buttons::LEFT))
          end
        end

        class EndTurnButtonClickListener < ClickListener
          def clicked(event, x, y)
            event.get_stage.map_stage.dungeon_level_actor.new_turn!
            true
          end
        end
      end
    end
  end
end
