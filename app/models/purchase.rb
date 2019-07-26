class Purchase < ApplicationRecord
  belongs_to :location
  belongs_to :purchased_by
  belongs_to :reimbursed_by
end
