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
      damage_effect = ::Dungeon::Level::Tile::Effect::Damage.new(BASE_DAMAGE)
      destination_tile.add_effect!(damage_effect)
    end

    def attack_character_actor
      # start slash animation
      # TODO
      character.actor.current_action = ::CharacterAction::SLASH

      # apply damage
      damage_effect = ::Dungeon::Level::Tile::Effect::Damage.new(BASE_DAMAGE)
      destination_tile.add_effect!(damage_effect)

      # animate attack receiver
      # TODO

      # finish slash animation
      # TODO
    end
  end
end
