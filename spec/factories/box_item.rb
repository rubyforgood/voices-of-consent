FactoryBot.define do
  factory :box_item do
    box
    inventory_type
    created_by
    updated_by
  end
end