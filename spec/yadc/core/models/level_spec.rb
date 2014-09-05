require 'spec_helper'

describe Yadc::Core::Dungeon::Level do
  subject { FactoryGirl.build(:level) }

  describe 'initialization' do
    it { expect(subject.tiles).to be_empty }
    it { expect(subject.characters).to be_empty }
  end

  describe '#spawn_character!' do
    let(:character) { FactoryGirl.build(:character) }

    context 'on a non-existant tile' do
      it 'does not spawn the character' do
        expect(subject.spawn_character!(character, 100, 100)).to be_falsey
        expect(character.current_tile).to be_nil
        expect(subject.characters).not_to include(character)
      end
    end

    context 'on a non-walkable tile' do
      it 'does not spawn the character' do
        expect(subject.spawn_character!(character, 2, 4)).to be_falsey
        expect(character.current_tile).to be_nil
        expect(subject.characters).not_to include(character)
      end
    end

    context 'on a walkable tile' do
      it 'spawns the character' do
        expect(subject.spawn_character!(character, 3, 2)).to be_truthy
        expect(character.current_tile.x_position).to eql 3
        expect(character.current_tile.y_position).to eql 2
        expect(subject.characters).to include(character)
      end

      context 'with a character already spawned' do
        before { subject.spawn_character!(character, 3, 2) }

        it "changes the character's current tile" do
          expect(subject.spawn_character!(character, 1, 2)).to be_truthy
          expect(character.current_tile.x_position).to eql 1
          expect(character.current_tile.y_position).to eql 2
          expect(subject.characters.select {|c| c == character}.count).to eql 1
        end
      end
    end
  end

  describe '#tile' do
    context 'with negative coordinates' do
      it 'returns nil' do
        expect(subject.tile(-1, 7)).to be_nil
      end

      it 'does nothing' do
        expect { subject.tile(-1, 7) }.not_to change { subject.tiles }
      end
    end

    context 'with bad coordinates' do
      it 'returns nil' do
        expect(subject.tile(10, 5)).to be_nil
      end

      it 'does nothing' do
        expect { subject.tile(10, 5) }.not_to change { subject.tiles }
      end
    end

    context 'with newly fetched coordinates' do
      it 'returns the tile' do
        tile = subject.tile(2, 3)

        expect(tile).to be_a(Yadc::Core::Dungeon::Level::Tile)
        expect(tile.x_position).to eql 2
        expect(tile.y_position).to eql 3
      end

      it 'adds the tile to the list' do
        expect { subject.tile(2, 3) }.to change { subject.tiles.count }.by(1)
      end
    end

    context 'with already fetched coordinates' do
      let!(:tile) { subject.tile(1, 3) }

      it 'has the tile in the list' do
        expect(subject.tiles).to include(tile)
      end

      it 'returns the tile' do
        tile = subject.tile(1, 3)

        expect(tile).to be_a(Yadc::Core::Dungeon::Level::Tile)
        expect(tile.x_position).to eql 1
        expect(tile.y_position).to eql 3
      end

      it 'does not add the tile to the list' do
        expect { subject.tile(1, 3) }.not_to change { subject.tiles }
      end
    end
  end

  describe '#height' do
    it { expect(subject.height).to eql 4 }
  end

  describe '#width' do
    it { expect(subject.width).to eql 5 }
  end
end
