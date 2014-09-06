require 'spec_helper'

describe Yadc::Core::Dungeon::Level::Tile do
  subject { FactoryGirl.build(:tile) }


  describe '#walkable?' do
    context 'with a character' do
      before { subject.character = FactoryGirl.build(:character) }

      it { expect(subject.walkable?).to be_falsey }
    end

    context 'with an impossible cost' do
      before { subject.cost = false }

      it { expect(subject.walkable?).to be_falsey }
    end

    context 'without a character and with a possible cost' do
      before do
        subject.character = nil
        subject.cost = 1
      end

      it { expect(subject.walkable?).to be_truthy }
    end
  end

  describe '#difficulty_impossible?' do
    before { subject.cost = cost }

    context 'with a cost set to 0' do
      let(:cost) { 0 }
      it { expect(subject.difficulty_impossible?).to be_falsey }
    end

    context 'with a cost set to 90000001' do
      let(:cost) { 90000001 }
      it { expect(subject.difficulty_impossible?).to be_falsey }
    end

    context 'with a cost set to false' do
      let(:cost) { false }
      it { expect(subject.difficulty_impossible?).to be_truthy }
    end
  end

  describe '#empty?' do
    context 'with no character' do
      before { subject.character = nil }

      it { expect(subject.empty?).to be_truthy }
    end

    context 'with a character' do
      before { subject.character = FactoryGirl.build(:character) }

      it { expect(subject.empty?).to be_falsey }
    end
  end

  describe '#adjacent_tile' do
    subject { FactoryGirl.build(:tile, x_position: 2, y_position: 0) }
    let(:adjacent_tile) { subject.adjacent_tile(direction) }

    context 'to the right' do
      let(:direction) { Yadc::Core::Direction::RIGHT }

      it { expect(adjacent_tile.x_position).to eql 3 }
      it { expect(adjacent_tile.y_position).to eql 0 }
    end

    context 'to the left' do
      let(:direction) { Yadc::Core::Direction::LEFT }

      it { expect(adjacent_tile.x_position).to eql 1 }
      it { expect(adjacent_tile.y_position).to eql 0 }
    end

    context 'above' do
      let(:direction) { Yadc::Core::Direction::UP }

      it { expect(adjacent_tile.x_position).to eql 2 }
      it { expect(adjacent_tile.y_position).to eql 1 }
    end

    context 'below' do
      let(:direction) { Yadc::Core::Direction::DOWN }

      it { expect(adjacent_tile).to be_nil }
    end
  end
end
