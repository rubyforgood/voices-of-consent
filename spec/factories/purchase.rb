# frozen_string_literal: true

FactoryBot.define do
  factory :purchase do
    total_price { 1.5 }
    purchased_by { nil }
    reimbursed_by { nil }
    reimbursement_check_number { 'MyString' }
    reimbursement_status { 'MyString' }

    location
  end
end
