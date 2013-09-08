class Character
  include CharacterInput
  include CharacterRenderer

  def initialize
    @current_direction = Direction::RIGHT
    load_animations
  end
end