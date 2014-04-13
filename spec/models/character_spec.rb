require 'spec_helper'

describe Character do

  its(:actor) { should be_nil }
  its(:health) { should eql Character::MAX_HEALTH }
  its(:armor) { should eql Character::BASE_ARMOR }
  its(:current_direction) { should eql Character::DEFAULT_DIRECTION }
  its(:current_tile) { should be_nil }
  its(:destination_tile) { should be_nil }

  describe '#current_tile=' do
    let(:tile) { FactoryGirl.build(:tile) }

    before { subject.current_tile = tile }

    it { expect(subject.current_tile).to eql tile }
    it { expect(subject.destination_tile).to eql tile }
  end

  pending '#use_skill!'
end
