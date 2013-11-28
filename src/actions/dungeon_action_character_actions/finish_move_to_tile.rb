module DungeonLevelCharacterActionsManager
  class FinishMoveToTile < RunnableAction

    def run
      actor.current_tile = actor.destination_tile
      actor.current_action = CharacterAction::STAND

      if direction = actor.input_translator.movement_direction
        actor.walk_to_next_tile!(direction)
      end
    end
  end
end