require 'spec_helper'

describe Skills::Move::Left do
  let(:character) { FactoryGirl.build(:character) }

  subject { Skills::Move::Left.new(character) }

  its(:direction) { should eql Direction::LEFT }
end
