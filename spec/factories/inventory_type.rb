FactoryBot.define do
  factory :inventory_type do
    name { Faker::House.furniture.titleize }
    description { Faker::Lorem.sentence }

    trait :needs_research do
      description {"An inventory type that needs research"}
      requires_research {true}
    end

    trait :no_research do
      description {"An inventory type that doesn't need research"}
      requires_research {false}
    end
    
  end
end
