class Purchase < ApplicationRecord
  has_many_attached :receipt_file_uploads
  belongs_to :location
  belongs_to :purchased_by, optional: true, class_name: "User", foreign_key: :purchased_by_id, inverse_of: :purchases
  belongs_to :reimbursed_by, optional: true, class_name: "User", foreign_key: :reimbursed_by_id, inverse_of: :reimbursed_purchases
end
