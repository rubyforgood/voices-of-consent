# frozen_string_literal: true

FactoryBot.define do
  factory :inventory_type do
    name { Faker::House.furniture.titleize }
    description { Faker::Lorem.sentence }
  end
end
