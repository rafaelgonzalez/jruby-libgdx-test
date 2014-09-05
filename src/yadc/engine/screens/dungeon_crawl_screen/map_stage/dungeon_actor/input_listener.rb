class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class MapStage < Stage
      class DungeonActor < Group
        class InputListener < InputListener

          attr_reader :dungeon_actor

          def initialize(dungeon_actor)
            super()
            @key_bindings = KeyBinding::Dungeon.new
            @dungeon_actor = dungeon_actor
          end

          def keyDown(input_event, keycode)
            if action = @key_bindings.input_action_from_keycode(keycode)
              dungeon_actor.public_send(action[0], *action[1])
              return true
            end

            false
          end
        end
      end
    end
  end
end
