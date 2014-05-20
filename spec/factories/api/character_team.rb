FactoryGirl.define do
  factory :character_team, class: CharacterTeam do
    ignore do
      name 'Test Team'
    end

    initialize_with { new(name) }
  end
end
