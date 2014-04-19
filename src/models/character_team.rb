class CharacterTeam

  attr_accessor :name
  attr_reader :characters

  def initialize(name)
    @name = name
    @characters = []
  end

  def add_character(character)
    if character.team.nil? and !characters.include?(character)
      characters.push(character)
      character.team = self
    end
  end
end
