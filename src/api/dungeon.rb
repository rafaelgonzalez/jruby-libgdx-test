class Dungeon

  attr_accessor :teams

  def initialize
    @teams = []
  end

  def current_playing_team
    teams.first
  end

  def end_current_playing_team_turn!
    current_playing_team.characters.map(&:reset_for_new_turn!)
    teams.push(teams.shift)
  end
end
