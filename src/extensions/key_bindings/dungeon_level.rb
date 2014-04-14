module KeyBinding
  class DungeonLevel < Base
    BINDINGS = {
      Keys::TAB => [:switch_control_to_next_playable_character!, []],
      Keys::ENTER => [:new_turn!, []],
    }

    def bindings
      BINDINGS
    end

    def categories
      {}
    end
  end
end
