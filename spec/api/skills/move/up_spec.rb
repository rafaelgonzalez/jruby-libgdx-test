require 'spec_helper'

describe Skills::Move::Up do
  let(:character) { FactoryGirl.build(:character) }

  subject { Skills::Move::Up.new(character) }

  it { expect(subject.direction).to eql Direction::UP }
end
