class Dungeon

  attr_accessor :teams
  attr_reader :current_level

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

  def current_level=(current_level)
    @current_level = current_level

    teams.each do |team|
      if team.artificial_intelligence
        team.artificial_intelligence.dungeon_level = current_level
      end
    end
  end
end
