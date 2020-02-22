FactoryBot.define do
  factory :box do
    box_request

    trait :is_designed do
      designed_by {create(:user, :designer)}
      designed_at { Time.now }
      design_reviewed_by_id  {create(:user, :reviewer).id}
      design_reviewed_at { Time.now }
      #how to update state?
    end
  end
end


#assembled_box = create(:box, :is_assembled), which also has/mimics the traits :is_designed, :is_researched, box_request#is_reviewed, etc, bc our /box_requests #index needs all the prior lifecycle phase to be true and all future lifecycle phases to be untrue to display correctly.