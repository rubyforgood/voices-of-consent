# frozen_string_literal: true

FactoryBot.define do
  factory :user_permission do
    user

    trait :can_assemble do
      permission { Permission::BOX_ASSEMBLER }
    end

    trait :can_design do
      permission { Permission::BOX_DESIGNER }
    end

    trait :can_follow_up do
      permission { Permission::BOX_FOLLOW_UPPER }
    end

    trait :can_research do
      permission { Permission::BOX_ITEM_RESEARCHER }
    end

    trait :can_review do
      permission { Permission::REQUEST_REVIEWER }
    end

    trait :can_ship do
      permission { Permission::SHIPPER }
    end

    trait :can_volunteer_at_events do
      permission { Permission::VOLUNTEER_AT_EVENTS }
    end
  end
end
