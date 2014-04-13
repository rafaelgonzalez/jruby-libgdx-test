module Skills
  class UnarmedAttack
    NAME = 'Unarmed attack'
    BASE_DAMAGE = 2

    attr_reader :character, :origin_tile, :direction, :destination_tile

    def initialize(character, origin_tile)
      @character = character
      @origin_tile = origin_tile
      @direction = character.current_direction
      @destination_tile = origin_tile.adjacent_tile(direction)
    end

    def execute!
      return false unless destination_tile
      character.actor.nil? ? attack_character : attack_character_actor
    end

    private

    def attack_character
      puts(I18n.t('skills.unarmed_attack.attack_message', attacker_name: character.name))

      if destination_tile.character
        total_damage = (BASE_DAMAGE - destination_tile.character.armor)
        destination_tile.character.health -= total_damage unless total_damage < 0

        puts(I18n.t('skills.unarmed_attack.hits_with_damage',
                    attacker_name: character.name,
                    attacked_name: destination_tile.character.name,
                    damage: total_damage))


        puts(I18n.t('skills.unarmed_attack.has_hp_left',
                    attacked_name: destination_tile.character.name,
                    health: destination_tile.character.health))
      else
        puts(I18n.t('skills.unarmed_attack.hits_nothing',
                    attacker_name: character.name))
      end
    end

    def attack_character_actor

      attack_character

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
  end
end
