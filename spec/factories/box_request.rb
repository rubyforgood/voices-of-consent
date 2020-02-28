FactoryBot.define do
  factory :box_request, aliases: [:messageable] do
    requester

    trait :has_reviewer do
      reviewed_by_id {create(:user, :reviewer).id}
      reviewed_at {Time.now}
    end

    trait :review_complete do 
      box
      reviewed_by_id {create(:user, :reviewer).id}
      reviewed_at {Time.now}
      aasm_state {"reviewed"}
    end


    summary { "This is a summary." }
    question_re_affect { "Question re effect." }
    question_re_referral_source { "Question about referral source." }
    question_re_current_situation { "Question about current situation." }
  end
end
