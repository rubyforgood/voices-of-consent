# frozen_string_literal: true

FactoryBot.define do
  factory :inventory_tally do
    inventory_type
    storage_location
  end
end
