require 'spec_helper'

describe Dungeon::Level::Tile do
  subject { FactoryGirl.build(:tile) }


  describe '#walkable?' do
    context 'with a character' do
      before { subject.character = FactoryGirl.build(:character) }

      its(:walkable?) { should be_false }
    end

    context 'with an impossible cost' do
      before { subject.cost = false }

      its(:walkable?) { should be_false }
    end

    context 'without a character and with a possible cost' do
      before do
        subject.character = nil
        subject.cost = 1
      end

      its(:walkable?) { should be_true }
    end
  end

  describe '#difficulty_impossible?' do
    before { subject.cost = cost }

    context 'with a cost set to 0' do
      let(:cost) { 0 }
      its(:difficulty_impossible?) { should be_false }
    end

    context 'with a cost set to 90000001' do
      let(:cost) { 90000001 }
      its(:difficulty_impossible?) { should be_false }
    end

    context 'with a cost set to false' do
      let(:cost) { false }
      its(:difficulty_impossible?) { should be_true }
    end
  end

  describe '#empty?' do
    context 'with no character' do
      before { subject.character = nil }

      its(:empty?) { should be_true }
    end

    context 'with a character' do
      before { subject.character = FactoryGirl.build(:character) }

      its(:empty?) { should be_false }
    end
  end

  describe '#adjacent_tile' do
    subject { FactoryGirl.build(:tile, x_position: 2, y_position: 0) }
    let(:adjacent_tile) { subject.adjacent_tile(direction) }

    context 'to the right' do
      let(:direction) { Direction::RIGHT }

      it { expect(adjacent_tile.x_position).to eql 3 }
      it { expect(adjacent_tile.y_position).to eql 0 }
    end

    context 'to the left' do
      let(:direction) { Direction::LEFT }

      it { expect(adjacent_tile.x_position).to eql 1 }
      it { expect(adjacent_tile.y_position).to eql 0 }
    end

    context 'above' do
      let(:direction) { Direction::UP }

      it { expect(adjacent_tile.x_position).to eql 2 }
      it { expect(adjacent_tile.y_position).to eql 1 }
    end

    context 'below' do
      let(:direction) { Direction::DOWN }

      it { expect(adjacent_tile).to be_nil }
    end
  end
end
