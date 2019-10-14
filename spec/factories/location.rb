FactoryBot.define do
  factory :location, aliases: [:storage_location] do
    name { Faker::Address.street_name }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    location_type { 1 }
  end
end
