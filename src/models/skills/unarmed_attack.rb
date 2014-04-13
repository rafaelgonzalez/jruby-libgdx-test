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
      puts("#{character.name} attacks with his bare fists!")

      if destination_tile.character
        total_damage = (BASE_DAMAGE - destination_tile.character.armor)
        destination_tile.character.health -= total_damage unless total_damage < 0
        puts "#{character.name} hits #{destination_tile.character.name} and deals #{total_damage} damage!"
        puts "#{destination_tile.character.name} has #{destination_tile.character.health} HP left."
      else
        puts("#{character.name} hits nothing.")
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
