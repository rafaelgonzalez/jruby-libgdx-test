class Character
  include CharacterRenderer

  def initialize
    @current_action = CharacterAction::STAND
    @current_direction = Direction::RIGHT
    initialize_rendering
  end
end