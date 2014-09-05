require 'spec_helper'

describe Yadc::Core::Skills::Move::Down do
  let(:character) { FactoryGirl.build(:character) }

  subject { Yadc::Core::Skills::Move::Down.new(character) }

  it { expect(subject.direction).to eql Yadc::Core::Direction::DOWN }
end
