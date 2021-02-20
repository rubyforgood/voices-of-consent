FactoryBot.define do
  factory :feedback do
    feedback { Faker::Hipster.paragraphs.join }
    category { Feedback::CATEGORY.sample }
    type { Feedback.to_s }
  end
end
