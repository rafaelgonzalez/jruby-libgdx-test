FactoryGirl.define do
  factory :character_team, class: CharacterTeam do
    ignore do
      name 'Test Team'
    end

    initialize_with { new(name) }

    trait :with_characters do
      sequence(:characters) { FactoryGirl.build_list(:character, 3) }
    end

    trait :with_ai do
      sequence(:artificial_intelligence) do
        ArtificialIntelligence::EndTurn.new(FactoryGirl.build(:level))
      end
    end
  end
end
