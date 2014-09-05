module Yadc
  class Engine < Game
    module KeyBinding
      class Character < Base
        BINDINGS = {
          Keys::W => [:use_skill!, ['Move::Up']],
          Keys::S => [:use_skill!, ['Move::Down']],
          Keys::A => [:use_skill!, ['Move::Left']],
          Keys::D => [:use_skill!, ['Move::Right']],
          Keys::E => [:use_skill!, [:unarmed_attack]]
        }

        CATEGORIES = {
          movement: [Keys::W, Keys::S, Keys::A, Keys::D]
        }

        def bindings
          BINDINGS
        end

        def categories
          CATEGORIES
        end
      end
    end
  end
end
