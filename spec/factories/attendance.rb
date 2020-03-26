# frozen_string_literal: true

FactoryBot.define do
  factory :attendance do
    meeting
    user
  end
end
