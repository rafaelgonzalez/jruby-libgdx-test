FactoryGirl.define do
  factory :character, class: Yadc::Core::Character do
    ignore do
      name 'Test character'
    end

    initialize_with { new(name) }

    trait :dead do
      health 0
    end
  end
end
