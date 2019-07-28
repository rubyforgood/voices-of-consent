FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }

      after(:build) { |u| u.password = u.password_confirmation = 'supersecret' }

    end
  end