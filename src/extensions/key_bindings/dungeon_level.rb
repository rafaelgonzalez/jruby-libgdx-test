module KeyBinding
  class DungeonLevel < Base
    BINDINGS = {
      Keys::TAB => [:switch_control_to_next_character!, []],
    }

    def bindings
      BINDINGS
    end
  end
end