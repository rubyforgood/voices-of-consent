FactoryBot.define do
  factory :box_request do
    requester

    summary { "This is a summary." }
    question_re_affect { "Question re effect." }
    question_re_referral_source { "Question about referral source." }
    question_re_current_situation { "Question about current situation." }
  end
end