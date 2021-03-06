module Yadc
  class Engine < Game
    module KeyBinding
      class Dungeon < Base
        BINDINGS = {
          Keys::TAB => [:switch_control_to_next_player_playable_character!, []],
          Keys::ENTER => [:end_current_playing_team_turn!, []],
        }

        def bindings
          BINDINGS
        end

        def categories
          {}
        end
      end
    end
  end
end
