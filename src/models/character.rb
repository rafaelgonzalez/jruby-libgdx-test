class Character
  include CharacterInputTranslator
  include CharacterRenderer

  def initialize
    @current_action = CharacterAction::STAND
    @current_direction = Direction::RIGHT
    initialize_input
    initialize_rendering
  end
end