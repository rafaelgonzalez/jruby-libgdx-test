require_relative 'end_turn_button/click_listener'

module Yadc
  class Engine < Game
    class DungeonCrawlScreen < ScreenAdapter
      class HudStage < Stage
        class Hud < Table
          class EndTurnButton

            attr_reader :button

            def initialize(skin)
              @button = TextButton.new('END TURN', skin)
              @click_listener = ClickListener.new(Input::Buttons::LEFT)
              button.add_listener(@click_listener)
            end

            def disable!
              button.set_disabled(true)
              button.remove_listener(@click_listener)
            end

            def enable!
              button.set_disabled(false)

              unless button.get_listeners.include?(@click_listener)
                button.add_listener(@click_listener)
              end
            end
          end
        end
      end
    end
  end
end
