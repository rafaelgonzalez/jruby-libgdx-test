require 'spec_helper'

describe Yadc::Core::Pathfinder::AStar do
  let(:level) { FactoryGirl.build(:level) }
  let(:start_tile) { level.tile(0, 0) }
  let(:end_tile) { level.tile(0, 3) }

  subject { Yadc::Core::Pathfinder::AStar.new(start_tile, end_tile) }

  describe '#initialize' do
    it { expect(subject.open_list).to be_empty }
    it { expect(subject.closed_list).to be_empty }
    it { expect(subject.path).to be_empty }

    it 'sets start_node and end_node with tiles' do
      expect(subject.start_node.tile).to eql start_tile
      expect(subject.end_node.tile).to eql end_tile
    end
  end

  describe '#find_path!' do
    context 'with a findable path' do
      it 'builds the correct path' do
        subject.find_path!

        expect(subject.path[0].x_position).to eql 0
        expect(subject.path[0].y_position).to eql 0

        expect(subject.path[1].x_position).to eql 0
        expect(subject.path[1].y_position).to eql 1

        expect(subject.path[2].x_position).to eql 1
        expect(subject.path[2].y_position).to eql 1

        expect(subject.path[3].x_position).to eql 1
        expect(subject.path[3].y_position).to eql 2

        expect(subject.path[4].x_position).to eql 1
        expect(subject.path[4].y_position).to eql 3

        expect(subject.path[5].x_position).to eql 0
        expect(subject.path[5].y_position).to eql 3
      end
    end

    context 'without a findable path' do
      let(:end_tile) { level.tile(3, 1) }

      it 'does not build a path' do
        subject.find_path!

        expect(subject.path).to be_empty
      end
    end
  end
end
