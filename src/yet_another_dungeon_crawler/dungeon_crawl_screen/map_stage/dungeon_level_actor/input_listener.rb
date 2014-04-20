require 'key_bindings/base'
require 'key_bindings/dungeon_level'

class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class MapStage < Stage
      class DungeonLevelActor < Group
        class InputListener < InputListener
          def initialize(level)
            super()
            @key_bindings = KeyBinding::DungeonLevel.new
            @level = level
          end

          def keyDown(input_event, keycode)
            if action = @key_bindings.input_action_from_keycode(keycode)
              @level.public_send(action[0], *action[1])
              return true
            end

            false
          end
        end
      end
    end
  end
end
