require 'spec_helper'

describe Skills::Move::Right do
  let(:character) { FactoryGirl.build(:character) }

  subject { Skills::Move::Right.new(character) }

  its(:direction) { should eql Direction::RIGHT }
end
