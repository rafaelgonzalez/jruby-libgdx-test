require 'spec_helper'

describe Pathfinder::AStar do
  let(:level) { FactoryGirl.build(:level) }
  let(:start_tile) { level.tile(0, 0) }
  let(:end_tile) { level.tile(0, 3) }

  subject { Pathfinder::AStar.new(start_tile, end_tile) }

  describe '#initialize' do
    its(:open_list) { should be_empty }
    its(:closed_list) { should be_empty }
    its(:path) { should be_empty }

    it 'sets start_node and end_node with tiles' do
      expect(subject.start_node.tile).to eql start_tile
      expect(subject.end_node.tile).to eql end_tile
    end
  end

  describe '#find_path!' do
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
end
