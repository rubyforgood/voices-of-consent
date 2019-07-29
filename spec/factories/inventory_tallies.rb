FactoryBot.define do
  factory :inventory_tally do
    additional_location_info { "MyString" }
    cached_quantity { 1 }
    inventory_type { nil }
    storage_location { nil }
  end
end
