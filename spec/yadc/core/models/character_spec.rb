require 'spec_helper'

describe Character do
  subject { FactoryGirl.build(:character, name: 'Master of combat') }

  describe 'initialization' do
    it { expect(subject.name).to eql 'Master of combat' }
    it { expect(subject.actor).to be_nil }
    it { expect(subject.maximum_stamina).to eql Character::BASE_STAMINA }
    it { expect(subject.stamina).to eql Character::BASE_STAMINA }
    it { expect(subject.maximum_mana).to eql  Character::BASE_MANA }
    it { expect(subject.mana).to eql  Character::BASE_MANA }
    it { expect(subject.maximum_health).to eql Character::BASE_HEALTH }
    it { expect(subject.health).to eql Character::BASE_HEALTH }
    it { expect(subject.maximum_action_points).to eql Character::BASE_ACTION_POINTS }
    it { expect(subject.action_points).to eql Character::BASE_ACTION_POINTS }
    it { expect(subject.current_direction).to eql Character::DEFAULT_DIRECTION }
    it { expect(subject.current_tile).to be_nil }
    it { expect(subject.destination_tile).to be_nil }
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
    it { expect(subject.armor).to eql Character::BASE_ARMOR }
  end

  describe '#alive?' do
    before { subject.health = health }

    context 'with health superior to 0' do
      let(:health) { 1 }
      it { expect(subject.alive?).to be_truthy }
  end

    context 'with health equal to 0' do
      let(:health) { 0 }
      it { expect(subject.alive?).to be_falsey }
    end

    context 'with health inferior to 0' do
      let(:health) { -1 }
      it { expect(subject.alive?).to be_falsey }
    end
  end

  describe '#playable?' do
    before { subject.health = health }

    context 'with health superior to 0' do
      let(:health) { 1 }
      it { expect(subject.playable?).to be_truthy }
    end

    context 'with health equal to 0' do
      let(:health) { 0 }
      it { expect(subject.playable?).to be_falsey }
    end

    context 'with health inferior to 0' do
      let(:health) { -1 }
      it { expect(subject.playable?).to be_falsey }
    end
  end

  describe '#spend_stamina!' do
    before do
      subject.stamina = 10
      subject.spend_stamina!(amount)
    end

    context 'with stamina superior to amount' do
      let(:amount) { 20 }
      it { expect(subject.stamina).to eql 0 }
    end

    context 'with stamina equal to amount' do
      let(:amount) { 10 }
      it { expect(subject.stamina).to eql 0 }
    end

    context 'with stamina inferior to amount' do
      let(:amount) { 5 }
      it { expect(subject.stamina).to eql 5 }
    end
  end

  describe '#spend_mana!' do
    before do
      subject.mana = 10
      subject.spend_mana!(amount)
    end

    context 'with mana superior to amount' do
      let(:amount) { 20 }
      it { expect(subject.mana).to eql 0 }
    end

    context 'with mana equal to amount' do
      let(:amount) { 10 }
      it { expect(subject.mana).to eql 0 }
    end

    context 'with mana inferior to amount' do
      let(:amount) { 5 }
      it { expect(subject.mana).to eql 5 }
    end
  end

  describe '#spend_action_points!' do
    before do
      subject.action_points = 10
      subject.spend_action_points!(amount)
    end

    context 'with action_points superior to amount' do
      let(:amount) { 20 }
      it { expect(subject.action_points).to eql 0 }
    end

    context 'with action_points equal to amount' do
      let(:amount) { 10 }
      it { expect(subject.action_points).to eql 0 }
    end

    context 'with action_points inferior to amount' do
      let(:amount) { 5 }
      it { expect(subject.action_points).to eql 5 }
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
