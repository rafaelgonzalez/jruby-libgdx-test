require 'spec_helper'

describe CharacterTeam do
  subject { FactoryGirl.build(:character_team, name: 'Team Awesome') }

  describe 'initialization' do
    its(:name) { should eql 'Team Awesome' }
    its(:characters) { should be_empty }
  end

  describe '#add_character' do
    let(:character) { FactoryGirl.build(:character) }

    context 'with a character with no team' do
      it 'adds the character to the team' do
        subject.add_character(character)

        expect(subject.characters.select{|c| c == character}.count).to eql 1
        expect(character.team).to eql subject
      end
    end

    context 'with a character already in the team' do
      before { subject.add_character(character) }

      it 'leaves the characters list unchanged' do
        subject.add_character(character)

        expect(subject.characters.select{|c| c == character}.count).to eql 1
        expect(character.team).to eql subject
      end
    end

    context 'with a character with a team' do
      let(:team) { FactoryGirl.build(:character_team) }

      before { character.team = team }

      it 'does not add the character to the team' do
        subject.add_character(character)

        expect(subject.characters).not_to include(character)
        expect(character.team).to eql team
      end
    end
  end

  describe '#current_controlled_character' do
    subject { FactoryGirl.build(:character_team, characters: characters.dup) }

    context 'with no characters' do
      let(:characters) { [] }

      its(:current_controlled_character) { should be_nil }
    end

    context 'with no playable characters' do
      let(:characters) { FactoryGirl.build_list(:character, 5, :dead) }

      its(:current_controlled_character) { should be_nil }
    end

    context 'with playable characters' do
      let(:characters) { FactoryGirl.build_list(:character, 5) }

      its(:current_controlled_character) { should eql characters.first }
    end
  end

  describe '#control_next_character!' do
    subject { FactoryGirl.build(:character_team, characters: characters.dup) }

    context 'with an unplayable character as the next character' do
      let(:playable_characters) { FactoryGirl.build_list(:character, 2) }
      let(:characters) { playable_characters + [FactoryGirl.build(:character, :dead)] }

      it 'sets the next playable character as the current_controlled_character' do
        subject.control_next_character!
        expect(subject.current_controlled_character).to eql playable_characters.last
      end
    end

    context 'with no playable characters left' do
      let(:characters) { FactoryGirl.build_list(:character, 2, :dead) }

      it 'does nothing' do
        expect { subject.control_next_character! }.not_to change{ subject.characters }
      end
    end
  end

  describe '#defeated?' do
    subject { FactoryGirl.build(:character_team, characters: characters) }

    context 'with at least one character alive' do
      let(:characters) do
        [
          FactoryGirl.build(:character, :dead),
          FactoryGirl.build(:character),
          FactoryGirl.build(:character, :dead)
        ]
      end

      its(:defeated?) { should be_false }
    end

    context 'with all characters dead' do
      let(:characters) { FactoryGirl.build_list(:character, 5, :dead) }

      its(:defeated?) { should be_true }
    end
  end
end
