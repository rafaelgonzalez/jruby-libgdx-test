class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class HudStage < Stage
      class Hud < Table
        class EndTurnButton

          attr_reader :button

          def initialize(skin)
            @button = TextButton.new('END TURN', skin)
            button.add_listener(ClickListener.new(Input::Buttons::LEFT))
          end
        end
      end
    end
  end
end

require_relative 'end_turn_button/click_listener'
