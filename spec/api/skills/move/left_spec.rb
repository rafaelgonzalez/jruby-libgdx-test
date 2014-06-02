require 'spec_helper'

describe Skills::Move::Left do
  let(:character) { FactoryGirl.build(:character) }

  subject { Skills::Move::Left.new(character) }

  it { expect(subject.direction).to eql Direction::LEFT }
end
