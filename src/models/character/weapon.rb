class Character
  class Weapon

    attr_reader :weapon_constant

    def initialize(weapon_constant)
      @weapon_constant = weapon_constant
    end
  end
end