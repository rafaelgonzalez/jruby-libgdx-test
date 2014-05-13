class CharacterTeam

  attr_accessor :name
  attr_reader :characters, :artificial_intelligence

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
    @characters.push(@characters.shift)
    control_next_character! unless current_controlled_character.playable?
  end

  def playable_characters
    characters.select do |character|
      character.playable?
    end
  end

  def defeated?
    characters.none?(&:alive?)
  end
end
