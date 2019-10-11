class Location < ApplicationRecord
  has_many :inventory_tallies
  has_many :meetings
  has_many :purchases
  has_many :volunteers, foreign_key: 'university_location_id',
                        dependent: :nullify

  enum location_type: {
    # Example types from ERD
    storage_unit: 0,
    shop: 1, # Can't call it `store` because it's an AR method
    meeting_space: 2,
    video_chat_link: 3,
    distribution_partner: 4,
    university: 5
  }
end
