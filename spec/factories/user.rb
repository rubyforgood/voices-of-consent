FactoryBot.define do
    factory :user, aliases: [:sent_by, :sent_to] do
      volunteer
      email { Faker::Internet.email }

      after(:build) { |u| u.password = u.password_confirmation = 'supersecret' }

    end

    factory :admin do
      email { Faker::Internet.email }
      password { "password"} 
      password_confirmation { "password" }
    end
  end
