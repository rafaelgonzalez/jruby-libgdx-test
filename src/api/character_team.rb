class CharacterTeam

  attr_accessor :name, :characters, :artificial_intelligence

  def initialize(name, artificial_intelligence = nil)
    @name = name
    @characters = []
    @artificial_intelligence = artificial_intelligence
  end

  def add_character(character)
    if character.team.nil? and !characters.include?(character)
      characters.push(character)
      character.team = self
    end
  end

  def current_controlled_character
    characters.first
  end

  def control_next_character!
    return if defeated?
    @characters.push(@characters.shift)
    control_next_character! unless current_controlled_character.playable?
  end

  def defeated?
    characters.none?(&:alive?)
  end
end
