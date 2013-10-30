module DungeonLevelCharacterActionsManager
  class FinishMoveToTile < RunnableAction
    def run
      actor.current_tile = actor.destination_tile
      actor.current_action = CharacterAction::STAND
    end
  end
end