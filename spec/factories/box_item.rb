FactoryBot.define do
  factory :box_item do
    box
    inventory_type
    created_by
    updated_by

    trait :research_needed do
      inventory_type {create(:inventory_type, :needs_research)}
    end

    trait :no_research_needed do
      inventory_type {create(:inventory_type, :no_research)}
    end
    
  end
end