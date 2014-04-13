module KeyBinding
  class DungeonLevel < Base
    BINDINGS = {
      Keys::TAB => [:switch_control_to_next_playable_character!, []],
    }

    def bindings
      BINDINGS
    end

    def categories
      {}
    end
  end
end
