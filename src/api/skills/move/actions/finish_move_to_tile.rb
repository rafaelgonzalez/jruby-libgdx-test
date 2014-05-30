module Skills
  module Move
    module Actions
      class FinishMoveToTile < RunnableAction

        def run
          actor.current_tile = actor.destination_tile
          actor.current_action = Character::Action::STAND

          direction = actor.input_translator.movement_direction
        end
      end
    end
  end
end
