class Dungeon

  attr_reader :teams, :current_level

  def initialize
    setup_teams
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

  private

  def setup_teams
    @teams = []

    player_character_1 = Character.new('Geralt')
    player_character_2 = Character.new('Syrio')
    player_character_3 = Character.new('Snake')

    vilain_character_1 = Character.new('Diablo')
    vilain_character_2 = Character.new('Baal')
    vilain_character_3 = Character.new('Mephisto')

    player_team = CharacterTeam.new("Player's characters")
    vilains_team = CharacterTeam.new('Vilains', ArtificialIntelligence::EndTurn.new)

    player_team.add_character(player_character_1)
    player_team.add_character(player_character_2)
    player_team.add_character(player_character_3)

    vilains_team.add_character(vilain_character_1)
    vilains_team.add_character(vilain_character_2)
    vilains_team.add_character(vilain_character_3)

    teams.push(player_team, vilains_team)
  end
end
