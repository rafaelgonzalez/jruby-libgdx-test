module Skills
  class UnarmedAttack < Base
    NAME = 'Unarmed attack'
    BASE_DAMAGE = 2

    RESOURCE = :stamina
    COST = 1

    attr_reader :character, :direction, :destination_tile

    def initialize(character)
      @character = character
      @direction = character.current_direction
      @destination_tile = character.current_tile.adjacent_tile(direction)
    end

    def execute!
      return false if !usable? or character.actor.is_moving?

      log_message(I18n.t('skills.unarmed_attack.attack_message', attacker_name: character.name))

      spend!

      if destination_tile.character
        log_message(I18n.t('skills.unarmed_attack.hits',
                    attacker_name: character.name,
                    attacked_name: destination_tile.character.name))

        destination_tile.character.take_damage!(BASE_DAMAGE)
      else
        log_message(I18n.t('skills.unarmed_attack.hits_nothing', attacker_name: character.name))
      end

      # start slash animation
      # TODO
      # character.actor.current_action = ::CharacterAction::SLASH

      # apply damage
      # damage_effect = ::Dungeon::Level::Tile::Effect::Damage.new(BASE_DAMAGE)
      # destination_tile.add_effect!(damage_effect)

      # animate attack receiver
      # TODO

      # finish slash animation
      # TODO
    end

    def resource
      RESOURCE
    end

    def cost
      COST
    end

    def usable?
      destination_tile and resource_available?
    end
  end
end
