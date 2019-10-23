class AbuseType < ApplicationRecord
  has_many :core_box_items
  has_many :box_request_abuse_types

  SUPPORTED_ABUSE_TYPES = ["emotional", "physical", "sexual"]
end
