FactoryBot.define do
    factory :volunteer do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      # email { Faker::Internet.email }
      street_address { Faker::Address.street_address }
      city { Faker::Address.city }
      state { Faker::Address.state }
      zip { Faker::Address.zip }
      ok_to_email { Faker::Boolean.boolean }
      ok_to_text { Faker::Boolean.boolean }
      ok_to_call { Faker::Boolean.boolean }
      ok_to_mail { Faker::Boolean.boolean }
      underage { Faker::Boolean.boolean }
    end
  end