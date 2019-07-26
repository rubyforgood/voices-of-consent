class Meeting < ApplicationRecord
  belongs_to :meeting_type
  belongs_to :location
end
