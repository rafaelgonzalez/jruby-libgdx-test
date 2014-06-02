require 'spec_helper'

describe Skills::Move::Right do
  let(:character) { FactoryGirl.build(:character) }

  subject { Skills::Move::Right.new(character) }

  it { expect(subject.direction).to eql Direction::RIGHT }
end
