# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: %i[sent_by sendable created_by updated_by] do
    volunteer
    email { Faker::Internet.email }

    after(:build) { |u| u.password = u.password_confirmation = 'supersecret' }

    trait :assembler do
      user_permissions { [create(:user_permission, :can_assemble)] }
    end

    trait :designer do
      user_permissions { [create(:user_permission, :can_design)] }
    end

    trait :follow_upper do
      user_permissions { [create(:user_permission, :can_follow_up)] }
    end

    trait :researcher do
      user_permissions { [create(:user_permission, :can_research)] }
    end

    trait :reviewer do
      user_permissions { [create(:user_permission, :can_review)] }
    end

    trait :shipper do
      user_permissions { [create(:user_permission, :can_ship)] }
    end
  end

  factory :admin do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
