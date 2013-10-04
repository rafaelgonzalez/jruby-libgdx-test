class Character

  attr_reader :current_action, :current_direction

  def initialize
    @current_action = CharacterAction::STAND
    @current_direction = Direction::RIGHT
  end
end