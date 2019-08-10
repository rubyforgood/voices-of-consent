FactoryBot.define do
  factory :location, aliases: [:storage_location] do
    name { "MyString" }
    street_address { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip { "MyString" }
    location_type { 1 }
  end
end
