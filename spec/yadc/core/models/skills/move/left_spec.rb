require 'spec_helper'

describe Yadc::Core::Skills::Move::Left do
  let(:character) { FactoryGirl.build(:character) }

  subject { Yadc::Core::Skills::Move::Left.new(character) }

  it { expect(subject.direction).to eql Yadc::Core::Direction::LEFT }
end
