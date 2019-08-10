FactoryBot.define do
  factory :abuse_type do
    sequence(:name) { |n| "AbuseType_#{n}" }
  end
end