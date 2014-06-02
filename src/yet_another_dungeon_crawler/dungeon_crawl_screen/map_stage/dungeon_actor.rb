require_relative 'dungeon_actor/input_listener'

class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class MapStage < Stage
      class DungeonActor < Group

        attr_reader :dungeon

        def initialize(dungeon)
          super()
          @dungeon = dungeon

          add_listener(InputListener.new(self))
        end

        def act(delta_time)
          super

          if dungeon.current_playing_team.artificial_intelligence
            end_turn_button.disable!
            get_stage.set_keyboard_focus(nil)
            dungeon.current_playing_team.artificial_intelligence.execute(delta_time)
          elsif get_stage.get_keyboard_focus.nil?
            end_turn_button.enable!
            switch_control_to_next_player_playable_character!
          else
            end_turn_button.enable!
          end

          get_stage.screen.hud_stage.hud_interface.top_message.set_text("#{dungeon.current_playing_team.name}")
        end

        def end_current_playing_team_turn!
          dungeon.end_current_playing_team_turn!

          if dungeon.current_playing_team.artificial_intelligence
            focus_on_current_playing_character
          else
            switch_control_to_next_player_playable_character!
          end
        end

        # Public: Gives keyboard focus to the next Character in the list, and moves Camera to the Character.
        #
        # Returns nothing.
        def switch_control_to_next_player_playable_character!
          dungeon.current_playing_team.control_next_character!
          get_stage.set_keyboard_focus(dungeon.current_playing_team.current_controlled_character.actor)

          focus_on_current_playing_character
        end

        private

        def focus_on_current_playing_character
          controlled_character = dungeon.current_playing_team.current_controlled_character

          get_stage.screen.hud_stage.focus_character = controlled_character

          get_stage.get_camera.move_to!(controlled_character.actor.screen_center_x_position,
                                        controlled_character.actor.screen_center_y_position)
        end

        def end_turn_button
          get_stage.screen.hud_stage.hud_interface.end_turn_button
        end
      end
    end
  end
end
