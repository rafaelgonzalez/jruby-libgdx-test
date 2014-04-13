module DeathCharacterAnimator

  def execute(character_actor)
    character_actor.add_action(
      ::Actions.sequence(
        Actions::AnimateDeath.new,
        Actions::FinishDeath.new
      )
    )
  end

  module Actions
    class AnimateDeath
      def initialize

      end
    end

    class FinishDeath < RunnableAction
      def run
        actor.current_action = CharacterAction::DEATH
      end
    end
  end
end
