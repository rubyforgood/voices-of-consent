FactoryBot.define do
  factory :user_permission do
    user

    trait :can_ship do
      permission { Permission::SHIPPER }
    end

    trait :can_volunteer_at_events do
      permission { Permission::VOLUNTEER_AT_EVENTS }
    end
  end
end
