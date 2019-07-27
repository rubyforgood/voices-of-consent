class BoxRequestAbuseType < ApplicationRecord
  belongs_to :box_request
  belongs_to :abuse_type
end
