class Dungeon

  attr_reader :teams

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
    vilains_team = CharacterTeam.new('Vilains')

    player_team.add_character(player_character_1)
    player_team.add_character(player_character_2)
    player_team.add_character(player_character_3)

    vilains_team.add_character(vilain_character_1)
    vilains_team.add_character(vilain_character_2)
    vilains_team.add_character(vilain_character_3)

    @teams.push(player_team, vilains_team)
  end
end
