class CharacterTeam

  attr_accessor :name
  attr_reader :characters

  def initialize(name)
    @name = name
    @characters = []
  end

  def add_character(character)
    unless characters.inlcude?(character)
      characters.push(character)
      character.team = self
    end
  end
end
