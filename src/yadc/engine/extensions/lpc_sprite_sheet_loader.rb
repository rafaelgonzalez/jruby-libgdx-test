module Yadc
  class Engine < Game
    class LpcSpriteSheetLoader
      SPRITE_WIDTH = 64
      SPRITE_HEIGHT = 64

      LPC_SPRITE_SHEETS_INDEXES = {
        Yadc::Core::Character::Action::DEATH => {
          Yadc::Core::Direction::UP => [20, 5],
          Yadc::Core::Direction::LEFT => [20, 5],
          Yadc::Core::Direction::DOWN => [20, 5],
          Yadc::Core::Direction::RIGHT => [20, 5],
        },

        Yadc::Core::Character::Action::STAND => {
          Yadc::Core::Direction::UP => [8, (0..0)],
          Yadc::Core::Direction::LEFT => [9, (0..0)],
          Yadc::Core::Direction::DOWN => [10, (0..0)],
          Yadc::Core::Direction::RIGHT => [11, (0..0)],
        },

        Yadc::Core::Character::Action::WALK => {
          Yadc::Core::Direction::UP => [8, (1..8)],
          Yadc::Core::Direction::LEFT => [9, (1..8)],
          Yadc::Core::Direction::DOWN => [10, (1..8)],
          Yadc::Core::Direction::RIGHT => [11, (1..8)]
        },

        Yadc::Core::Character::Action::SLASH => {
          Yadc::Core::Direction::UP => [12, (0..5)],
          Yadc::Core::Direction::LEFT => [13, (0..5)],
          Yadc::Core::Direction::DOWN => [14, (0..5)],
          Yadc::Core::Direction::RIGHT => [15, (0..5)]
        }
      }

      ANIMATIONS_SPEED = 0.15

      def self.animations_from_sprite_sheet_file(file_name)
        sprite_sheet_loader = SpriteSheetLoader.new(file_name, SPRITE_WIDTH, SPRITE_HEIGHT)
        animations(sprite_sheet_loader)
      end


      private

      def self.animations(sprite_sheet_loader)
        animations = {}

        LPC_SPRITE_SHEETS_INDEXES.each do |action, directions|
          animations[action] ||= {}

          directions.each do |direction, indexes|
            animations[action][direction] = sprite_sheet_loader.animation(indexes[0], indexes[1], ANIMATIONS_SPEED)
          end
        end

        animations
      end
    end
  end
end
