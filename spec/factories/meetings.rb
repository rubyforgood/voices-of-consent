FactoryBot.define do
  factory :meeting do
    title { "MyString" }
    location_id { create(:location).id }
    start_time { Time.zone.parse('2012-07-11 11:00') }
    end_time { Time.zone.parse('2012-07-11 14:00') }
    tenative { true }
    meeting_type_id { create(:meeting_type).id }
  end

  factory :meeting_type do
    name { "MyString" }
    description { "MyString" }
  end
end

