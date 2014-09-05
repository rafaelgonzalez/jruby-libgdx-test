require 'spec_helper'

describe Skills::Move::Down do
  let(:character) { FactoryGirl.build(:character) }

  subject { Skills::Move::Down.new(character) }

  it { expect(subject.direction).to eql Direction::DOWN }
end
