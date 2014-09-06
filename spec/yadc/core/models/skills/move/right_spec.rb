require 'spec_helper'

describe Yadc::Core::Skills::Move::Right do
  let(:character) { FactoryGirl.build(:character) }

  subject { Yadc::Core::Skills::Move::Right.new(character) }

  it { expect(subject.direction).to eql Yadc::Core::Direction::RIGHT }
end
