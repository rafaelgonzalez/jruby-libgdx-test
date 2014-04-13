FactoryGirl.define do
  factory :tile, class: Dungeon::Level::Tile do
    ignore do
      x_position 3
      y_position 7
      dungeon_level { Dungeon::Level.new }
    end

    initialize_with { new(x_position, y_position, dungeon_level) }
  end
end
