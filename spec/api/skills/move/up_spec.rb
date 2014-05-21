require 'spec_helper'

describe Skills::Move::Up do
  let(:character) { FactoryGirl.build(:character) }

  subject { Skills::Move::Up.new(character) }

  its(:direction) { should eql Direction::UP }
end
