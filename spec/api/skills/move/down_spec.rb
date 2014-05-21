require 'spec_helper'

describe Skills::Move::Down do
  let(:character) { FactoryGirl.build(:character) }

  subject { Skills::Move::Down.new(character) }

  its(:direction) { should eql Direction::DOWN }
end
