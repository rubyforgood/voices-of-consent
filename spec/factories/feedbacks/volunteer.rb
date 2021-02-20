FactoryBot.define do
  factory :volunteer_feedback, class: Feedbacks::Volunteer do
    feedback { Faker::Hipster.paragraphs.join }
    category { Feedback::CATEGORY.sample }
  end
end
