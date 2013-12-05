module Skills
  class UnarmedAttack
    NAME = 'Unarmed attack'
    BASE_DAMAGE = 2

    attr_reader :owner, :origin_tile, :direction, :destination_tile

    def initialize(owner, origin_tile)
      @owner = owner
      @origin_tile = origin_tile
      @direction = owner.current_direction
      @destination_tile = origin_tile.adjacent_tile(direction)
    end

    def execute!
      return false unless destination_tile

      # start slash animation
      # TODO
      owner.current_action = ::CharacterAction::SLASH

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