FactoryBot.define do
  factory :volunteer_feedback, class: Feedbacks::Volunteer, parent: :feedback do
    category { Feedback::CATEGORY.sample }
  end
end
