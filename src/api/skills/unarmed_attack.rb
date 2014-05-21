module Skills
  class UnarmedAttack < Base
    NAME = 'Unarmed attack'
    BASE_DAMAGE = 2

    COSTS = {
      action_points: 1,
      stamina: 1
    }

    attr_reader :character, :direction, :destination_tile

    def initialize(character)
      @character = character
      @direction = character.current_direction
      @destination_tile = character.current_tile.adjacent_tile(direction)
    end

    def execute!
      return false if !usable? or character.actor.is_moving?

      spend_resources!

      if destination_tile.character
        destination_tile.character.take_damage!(BASE_DAMAGE)
      end

      # start slash animation
      # TODO
      # character.actor.current_action = ::CharacterAction::SLASH

      # apply damage

      # animate attack receiver
      # TODO

      # finish slash animation
      # TODO
    end

    def costs
      COSTS
    end

    def usable?
      destination_tile and resources_available?
    end
  end
end
