module Yadc
  class Engine < Game
    module KeyBinding
    end
  end
end

require_relative 'key_bindings/base'
require_relative 'key_bindings/camera'
require_relative 'key_bindings/character'
require_relative 'key_bindings/dungeon'
