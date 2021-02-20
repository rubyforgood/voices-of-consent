FactoryBot.define do
  factory :feedback do
    description { Faker::Hipster.paragraphs.join }
    category { Feedback::CATEGORY.sample }
    type { Feedback.to_s }
  end
end
