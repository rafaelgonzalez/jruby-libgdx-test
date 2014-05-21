require 'spec_helper'

describe Character do
  subject { FactoryGirl.build(:character, name: 'Master of combat') }

  describe 'initialization' do
    its(:name) { should eql 'Master of combat' }
    its(:actor) { should be_nil }
    its(:maximum_stamina) { should eql Character::BASE_STAMINA }
    its(:stamina) { should eql Character::BASE_STAMINA }
    its(:maximum_mana) { should eql Character::BASE_MANA }
    its(:mana) { should eql Character::BASE_MANA }
    its(:maximum_health) { should eql Character::BASE_HEALTH }
    its(:health) { should eql Character::BASE_HEALTH }
    its(:maximum_action_points) { should eql Character::BASE_ACTION_POINTS }
    its(:action_points) { should eql Character::BASE_ACTION_POINTS }
    its(:current_direction) { should eql Character::DEFAULT_DIRECTION }
    its(:current_tile) { should be_nil }
    its(:destination_tile) { should be_nil }
  end

  describe '#current_tile=' do
    let(:tile) { FactoryGirl.build(:tile) }

    before { subject.current_tile = tile }

    it { expect(subject.current_tile).to eql tile }
    it { expect(subject.destination_tile).to eql tile }
    it { expect(tile.character).to eql subject }
  end

  describe '#take_damage!' do
    context 'with damage inferior to armor' do
      let(:damage) { subject.armor - 1 }

      it 'does not change health' do
        expect { subject.take_damage!(damage) }.not_to change { subject.health }
      end
    end

    context 'with damage equal to armor' do
      let(:damage) { subject.armor }

      it 'does not change health' do
        expect { subject.take_damage!(damage) }.not_to change { subject.health }
      end
    end

    context 'with damage superior to armor' do
      let(:damage) { subject.armor + 1 }

      it 'changes health' do
        expect { subject.take_damage!(damage) }.to change { subject.health }.by(-1)
      end

      context 'with health equal to 0' do
        before { subject.health = 0 }

        it 'does keep health to 0' do
          expect { subject.take_damage!(damage) }.not_to change { subject.health }
        end
      end
    end
  end

  describe '#armor' do
    its(:armor) { should eql Character::BASE_ARMOR }
  end

  describe '#alive?' do
    before { subject.health = health }

    context 'with health superior to 0' do
      let(:health) { 1 }
      its(:alive?) { should be_true }
    end

    context 'with health equal to 0' do
      let(:health) { 0 }
      its(:alive?) { should be_false }
    end

    context 'with health inferior to 0' do
      let(:health) { -1 }
      its(:alive?) { should be_false }
    end
  end

  describe '#playable?' do
    before { subject.health = health }

    context 'with health superior to 0' do
      let(:health) { 1 }
      its(:playable?) { should be_true }
    end

    context 'with health equal to 0' do
      let(:health) { 0 }
      its(:playable?) { should be_false }
    end

    context 'with health inferior to 0' do
      let(:health) { -1 }
      its(:playable?) { should be_false }
    end
  end

  describe '#spend_stamina!' do
    before do
      subject.stamina = 10
      subject.spend_stamina!(amount)
    end

    context 'with stamina superior to amount' do
      let(:amount) { 20 }
      its(:stamina) { should eql 0 }
    end

    context 'with stamina equal to amount' do
      let(:amount) { 10 }
      its(:stamina) { should eql 0 }
    end

    context 'with stamina inferior to amount' do
      let(:amount) { 5 }
      its(:stamina) { should eql 5 }
    end
  end

  describe '#spend_mana!' do
    before do
      subject.mana = 10
      subject.spend_mana!(amount)
    end

    context 'with mana superior to amount' do
      let(:amount) { 20 }
      its(:mana) { should eql 0 }
    end

    context 'with mana equal to amount' do
      let(:amount) { 10 }
      its(:mana) { should eql 0 }
    end

    context 'with mana inferior to amount' do
      let(:amount) { 5 }
      its(:mana) { should eql 5 }
    end
  end

  describe '#spend_action_points!' do
    before do
      subject.action_points = 10
      subject.spend_action_points!(amount)
    end

    context 'with action_points superior to amount' do
      let(:amount) { 20 }
      its(:action_points) { should eql 0 }
    end

    context 'with action_points equal to amount' do
      let(:amount) { 10 }
      its(:action_points) { should eql 0 }
    end

    context 'with action_points inferior to amount' do
      let(:amount) { 5 }
      its(:action_points) { should eql 5 }
    end
  end

  describe '#reset_for_new_turn!' do
    subject do
      FactoryGirl.build(:character,
                        maximum_health: 20, health: 12,
                        maximum_stamina: 25, stamina: 18,
                        maximum_mana: 10, mana: 6)
    end

    it 'restores 1 to stamina and mana' do
      expect { subject.reset_for_new_turn! }.not_to change { subject.health }
      expect { subject.reset_for_new_turn! }.to change { subject.stamina }.by(1)
      expect { subject.reset_for_new_turn! }.to change { subject.mana }.by(1)
    end

    context 'with a living character' do
      context 'with maximum stamina' do
        before { subject.stamina = subject.maximum_stamina }

        it 'does not change stamina' do
          expect { subject.reset_for_new_turn! }.not_to change { subject.stamina }
        end
      end

      context 'with maximum mana' do
        before { subject.mana = subject.maximum_mana }

        it 'does not change mana' do
          expect { subject.reset_for_new_turn! }.not_to change { subject.mana }
        end
      end
    end

    context 'with a dead character' do
      before { subject.health = 0 }

      it 'does not restore 1 to stamina and mana' do
        expect { subject.reset_for_new_turn! }.not_to change { subject.health }
        expect { subject.reset_for_new_turn! }.not_to change { subject.stamina }
        expect { subject.reset_for_new_turn! }.not_to change { subject.mana }
      end
    end
  end

  pending '#use_skill!'
end
