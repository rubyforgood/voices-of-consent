# frozen_string_literal: true

FactoryBot.define do
  factory :requester do
    first_name { 'George' }
    last_name { 'Mills' }
    email { 'gmills@example.com' }
    street_address { '123 Main St.' }
    city { 'Anytown' }
    state { 'PA' }
    zip { '86753' }
    ok_to_email { true }
    ok_to_text { true }
    ok_to_call { true }
    ok_to_mail { true }
    underage { false }

    factory :requester_with_box_requests do
      transient { request_count { 1 } }

      after(:create) do |_user, evaluator|
        create_list(:box_request, evaluator.request_count, requester: requester)
      end
    end
  end
end
