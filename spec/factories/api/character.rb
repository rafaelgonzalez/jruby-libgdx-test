FactoryGirl.define do
  factory :character, class: Character do
    ignore do
      name 'Test character'
    end

    initialize_with { new(name) }
  end
end
