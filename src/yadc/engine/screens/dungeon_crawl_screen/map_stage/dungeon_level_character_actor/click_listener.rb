module Yadc
  class Engine < Game
    class DungeonCrawlScreen < ScreenAdapter
      class MapStage < Stage
        class DungeonLevelCharacterActor < Actor
          class ClickListener < ClickListener

            attr_reader :character, :previous_character

            def initialize(character)
              super()
              @character = character
            end

            def enter(event, x, y, pointer, actor)
              @previous_character = get_focus_character(event)
              set_focus_character(event, character)
              true
            end

            def exit(event, x, y, pointer, actor)
              character = get_screen(event).map_stage.get_keyboard_focus
              set_focus_character(event, @previous_character)
              true
            end

            private

            def get_focus_character(event)
              event.get_stage.screen.hud_stage.focus_character
            end

            def set_focus_character(event, character)
              event.get_stage.screen.hud_stage.focus_character = character
            end

            def get_screen(event)
              event.get_stage.screen
            end
          end
        end
      end
    end
  end
end
