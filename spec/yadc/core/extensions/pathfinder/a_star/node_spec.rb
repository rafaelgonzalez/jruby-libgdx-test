require 'spec_helper'

describe Yadc::Core::Pathfinder::AStar::Node do
  let(:tile) { FactoryGirl.build(:tile) }

  subject { Yadc::Core::Pathfinder::AStar::Node.new(tile) }

  it { expect(subject.tile).to eql tile }

  describe '#==' do
    let(:tile) { FactoryGirl.build(:tile, x_position: 1, y_position: 3) }
    let(:node) { Yadc::Core::Pathfinder::AStar::Node.new(tile) }

    context 'with the same tile' do
      let(:other_node) { Yadc::Core::Pathfinder::AStar::Node.new(tile) }

      it { expect(node == other_node).to be_truthy }
    end

    context 'with a different tile' do
      let(:other_tile) { FactoryGirl.build(:tile, x_position: 1, y_position: 3) }
      let(:other_node) { Yadc::Core::Pathfinder::AStar::Node.new(other_tile) }

      it { expect(node == other_node).to be_falsey }
    end
  end

  describe '#calculate_scores!' do
    let(:start_tile) { FactoryGirl.build(:tile, x_position: 0, y_position: 0, cost: 3) }
    let(:start_node) { Yadc::Core::Pathfinder::AStar::Node.new(start_tile) }

    let(:tile) { FactoryGirl.build(:tile, x_position: 0, y_position: 1, cost: 2) }
    subject { Yadc::Core::Pathfinder::AStar::Node.new(tile) }

    let(:end_tile) { FactoryGirl.build(:tile, x_position: 0, y_position: 3) }
    let(:end_node) { Yadc::Core::Pathfinder::AStar::Node.new(end_tile) }

    context 'with a parent' do
      before { subject.parent = start_node }

      it 'calculates the scores' do
        subject.calculate_scores!(end_node)

        expect(subject.g).to eql 5
        expect(subject.h).to eql 20
        expect(subject.f).to eql 25
      end
    end

    context 'with no parent' do
      it 'does not calculate the scores' do
        subject.calculate_scores!(end_node)

        expect(subject.g).to be_nil
        expect(subject.h).to be_nil
        expect(subject.f).to be_nil
      end
    end
  end
end
