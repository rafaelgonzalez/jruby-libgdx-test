module Weapon
  module Sprite
    ARROW_SKELETON = 1
    ARROW = 2
    BOW_SKELETON = 3
    BOW = 4
    DAGGER_FEMALE = 5
    DAGGER_MALE = 6
    GREATBOW = 7
    RECURVEBOX = 8
    SHIELD_MALE_FOR_BODY = 9
    SHIELD_MALE_FOR_HAT = 10
    SPEAR = 11
    STEEL_WAND_FEMALE = 12
    WOOD_WAND_FEMALE = 13
    WOOD_WAND_MALE = 14

    ASSETS_FILES_MAP = {
      ARROW_SKELETON => 'assets/weapons/arrow_skeleton.png',
      ARROW => 'assets/weapons/arrow.png',
      BOW_SKELETON => 'assets/weapons/bow_skeleton.png',
      BOW => 'assets/weapons/bow.png',
      DAGGER_FEMALE => 'assets/weapons/dagger_female.png',
      DAGGER_MALE => 'assets/weapons/dagger_male.png',
      GREATBOW => 'assets/weapons/greatbow.png',
      RECURVEBOX => 'assets/weapons/recurvebow.png',
      SHIELD_MALE_FOR_BODY => 'assets/weapons/shield_male_cutoutforbody.png',
      SHIELD_MALE_FOR_HAT => 'assets/weapons/shield_male_cutoutforhat.png',
      SPEAR => 'assets/weapons/spear.png',
      STEEL_WAND_FEMALE => 'assets/weapons/steelwand_female.png',
      WOOD_WAND_FEMALE => 'assets/weapons/woodwand_female.png',
      WOOD_WAND_MALE => 'assets/weapons/woodwand_male.png'
    }

    # Public: Get the sprite sheet file from the given Weapon constant.
    #
    # weapon_constant - A Weapon constant.
    #
    # Returns a String
    def self.sprite_sheet_file(weapon_constant)
      ASSETS_FILES_MAP[weapon_constant]
    end
  end
end
