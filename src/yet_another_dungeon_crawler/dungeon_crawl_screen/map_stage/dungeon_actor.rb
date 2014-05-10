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
          switch_control_to_next_playable_character! unless get_stage.get_keyboard_focus
        end

        def end_current_playing_team_turn!
          dungeon.end_current_playing_team_turn!
          switch_control_to_next_playable_character!
        end

        # Public: Gives keyboard focus to the next Character in the list, and moves Camera to the Character.
        #
        # Returns nothing.
        def switch_control_to_next_playable_character!
          dungeon.current_playing_team.control_next_character!
          get_stage.set_keyboard_focus(dungeon.current_playing_team.current_controlled_character.actor)

          get_stage.screen.hud_stage.focus_character = dungeon.current_playing_team.current_controlled_character

          get_stage.get_camera.move_to!(
            dungeon.current_playing_team.current_controlled_character.actor.screen_center_x_position,
            dungeon.current_playing_team.current_controlled_character.actor.screen_center_y_position
          )
        end
      end
    end
  end
end
