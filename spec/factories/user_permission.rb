FactoryBot.define do
  factory :user_permission do
    user

    trait :can_ship do
      permission { Permission::SHIPPER }
    end
  end
end