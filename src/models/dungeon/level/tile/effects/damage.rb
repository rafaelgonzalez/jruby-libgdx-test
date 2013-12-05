class Dungeon::Level::Tile::Effect
  class Damage
    attr_accessor :tile
    attr_reader :amount

    def initialize(amount)
      @amount = amount
      @tile = nil
    end

    def apply!
      raise RuntimeError.new("Can not apply this effect before adding it to a Tile (Tile#add_effect!)") unless tile
      if tile.character
        total_damage = (amount - tile.character.armor)
        tile.character.health -= total_damage unless total_damage < 0
      end
      tile.remove_effect!(self)
    end
  end
end