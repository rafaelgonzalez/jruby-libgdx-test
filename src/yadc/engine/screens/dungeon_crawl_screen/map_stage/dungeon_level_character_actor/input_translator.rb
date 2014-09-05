class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class MapStage < Stage
      class DungeonLevelCharacterActor < Actor
        class InputTranslator
          include Input

          def initialize(actor)
            @actor = actor
            @key_bindings = KeyBinding::Character.new
          end

          # Public: Get the currently desired movement direction for the Character
          #
          # Returns a Direction constant, or nil if Character does not want to move.
          def movement_direction
            if wants_to_move?
              callback = @key_bindings.pressed_category_callbacks(:movement).first
              @actor.send(callback[0], *callback[1])
            else
              nil
            end
          end

          private

          def wants_to_move?
            if has_keyboard_focus?
              @key_bindings.category_pressed?(:movement)
            else
              false
            end
          end

          # Public: Determines if the Character currently has the keyboard focus.
          #
          # Returns a Boolean.
          def has_keyboard_focus?
            @actor == @actor.get_stage.get_keyboard_focus
          end
        end
      end
    end
  end
end
