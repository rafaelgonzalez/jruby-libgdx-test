require_relative 'hud_stage/hud'

module Yadc
  class Engine < Game
    class DungeonCrawlScreen < ScreenAdapter
      class HudStage < Stage

        attr_accessor :focus_character
        attr_reader :screen, :hud_interface

        def initialize(screen)
          super()

          @screen = screen
          @hud_interface = Hud.new
          @focus_character = nil

          self.add_actor(hud_interface)
        end

        def draw
          super

          update_character_details
        end

        private

        def update_character_details
          if focus_character.nil? and hud_interface.character_details.table.is_visible
            hud_interface.character_details.table.set_visible(false)

          elsif !focus_character.nil?
            unless hud_interface.character_details.table.is_visible
              hud_interface.character_details.table.set_visible(true)
            end

            hud_interface.character_details.set_with_character(focus_character)
          end
        end
      end
    end
  end
end
