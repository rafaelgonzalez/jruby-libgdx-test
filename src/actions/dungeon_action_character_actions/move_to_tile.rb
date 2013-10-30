module DungeonLevelCharacterActionsManager
  class MoveToTile < MoveToAction
    def initialize(destination_tile)
      super()

      set_x destination_tile.character_x_position
      set_y destination_tile.character_y_position

      set_duration(0.5)
    end
  end
end