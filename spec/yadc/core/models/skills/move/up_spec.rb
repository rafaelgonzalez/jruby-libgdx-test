require 'spec_helper'

describe Yadc::Core::Skills::Move::Up do
  let(:character) { FactoryGirl.build(:character) }

  subject { Yadc::Core::Skills::Move::Up.new(character) }

  it { expect(subject.direction).to eql Yadc::Core::Direction::UP }
end
