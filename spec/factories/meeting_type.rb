FactoryBot.define do
  factory :meeting_type do
    sequence(:name) { |n| "MeetingType_#{n}" }
  end
end