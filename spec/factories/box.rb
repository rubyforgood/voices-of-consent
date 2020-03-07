FactoryBot.define do
  factory :box do
    box_request

    trait :reviewed do
      box_request {(create(:box_request, :review_complete))}
    end

    trait :design_in_progress do 
      reviewed
      aasm_state { "design_in_progress"}
      designed_by_id {create(:user, :designer).id}
      designed_at { Time.now }
      design_reviewed_by_id  {create(:user, :reviewer).id}
      design_reviewed_at { Time.now }
    end

    trait :designed do 
      design_in_progress
      aasm_state { "designed"}
      box_items {create_list(:box_item, 1, :research_needed)}
    end

    trait :research_in_progress do 
      designed
      aasm_state {"research_in_progress"}
      researched_by_id {create(:user, :researcher).id}
    end

    trait :researched do 
      research_in_progress
      aasm_state {"researched"}
    end

    trait :assembly_in_progress do 
      researched
      aasm_state {"assembly_in_progress"}
      assembled_by_id {create(:user, :assembler).id}
    end

    trait :assembled do 
      assembly_in_progress
      aasm_state {"assembled"}
    end

    trait :shipping_in_progress do 
      assembled
      aasm_state {"shipping_in_progress"}
      shipped_by_id {create(:user, :shipper).id}
    end

    trait :shipped do 
      shipping_in_progress
      aasm_state {"shipped"}
    end

    trait :follow_up_in_progress do 
      shipping_in_progress
      aasm_state {"follow_up_in_progress"}
      followed_up_by_id {create(:user, :follow_upper).id}
    end

    trait :followed_up do 
      follow_up_in_progress
      aasm_state {"followed_up"}
    end

  end
end