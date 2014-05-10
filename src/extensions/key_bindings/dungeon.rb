module KeyBinding
  class Dungeon < Base
    BINDINGS = {
      Keys::TAB => [:switch_control_to_next_playable_character!, []],
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
