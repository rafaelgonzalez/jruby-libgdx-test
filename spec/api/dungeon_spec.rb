require 'spec_helper'

describe Dungeon do

  describe 'initialization' do
    its(:teams) { should be_empty }
  end

  describe '#current_playing_team' do
    subject { FactoryGirl.build(:dungeon, teams: teams.dup) }

    context 'with no teams' do
      let(:teams) { [] }

      its(:current_playing_team) { should be_nil }
    end

    context 'with teams' do
      let(:teams) { FactoryGirl.build_list(:character_team, 5) }

      its(:current_playing_team) { should eql teams.first }
    end
  end

  describe '#end_current_playing_team_turn!' do
    let(:teams) { FactoryGirl.build_list(:character_team, 3, :with_characters) }
    subject { FactoryGirl.build(:dungeon, teams: teams.dup) }

    it 'sets the next team as the current playing team' do
      expect(subject.current_playing_team).to eql teams[0]

      teams[0].characters.each do |character|
        expect(character).to receive(:reset_for_new_turn!).once.with(no_args)
      end

      expect { subject.end_current_playing_team_turn! }.to change { subject.teams }

      expect(subject.current_playing_team).to eql teams[1]
    end
  end

  describe '#current_level=' do
    let(:ai_teams) { FactoryGirl.build_list(:character_team, 3, :with_ai) }
    let(:level) { FactoryGirl.build(:level) }

    subject { FactoryGirl.build(:dungeon, teams: ai_teams) }

    it "changes the dungeon's current level" do
      subject.current_level = level
      expect(subject.current_level).to eql level
    end

    it 'updates the dungeon level of artificial intelligences' do
      ai_teams.each do |team|
        expect(team.artificial_intelligence.dungeon_level).to be_nil
      end

      subject.current_level = level

      ai_teams.each do |team|
        expect(team.artificial_intelligence.dungeon_level).to eql level
      end
    end
  end
end
