class Location < ApplicationRecord
  enum type: {
    # Example types from ERD
    storage_unit: 0,
    shop: 1, # Can't call it `store` because it's an AR method
    meeting_space: 2,
    video_chat_link: 3,
    distribution_partner: 4,
  }
end
