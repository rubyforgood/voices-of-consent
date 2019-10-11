FactoryBot.define do
  factory :inventory_tally do
    additional_location_info { "MyString" }
    inventory_type { nil }
    storage_location { nil }
  end
end
