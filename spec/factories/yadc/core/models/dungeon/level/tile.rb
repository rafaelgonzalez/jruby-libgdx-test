FactoryGirl.define do
  factory :tile, class: Dungeon::Level::Tile do
    ignore do
      x_position 3
      y_position 7
      cost 1
      sequence(:dungeon_level) { FactoryGirl.build(:level) }
    end

    initialize_with { new(x_position, y_position, cost, dungeon_level) }
  end
end
