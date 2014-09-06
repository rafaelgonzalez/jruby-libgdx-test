require 'spec_helper'

describe Yadc::Core::Pathfinder::AStar::Heuristic::Manhattan do
  describe '.calculate' do
    it 'calculates the heuristic score' do
      expect(described_class.calculate(2, 5, 6, 1)).to eql 80
      expect(described_class.calculate(4, 1, 3, 2)).to eql 20
      expect(described_class.calculate(3, 2, 1, 3)).to eql 30
    end
  end
end
