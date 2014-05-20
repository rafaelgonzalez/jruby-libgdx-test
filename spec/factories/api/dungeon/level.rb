FactoryGirl.define do
  factory :level, class: Dungeon::Level do
    ignore do
      sequence(:tiles_array) do
        [
          [1, false, 3, 1],
          [1, 2, 1, false],
          [false, 1, 1, 1]
        ]
      end

      sequence(:dungeon) { FactoryGirl.build(:dungeon) }
    end

    initialize_with { new(tiles_array, dungeon) }
  end
end
