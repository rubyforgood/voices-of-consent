class Box < ApplicationRecord
  belongs_to :box_request
  belongs_to :designed_by
  belongs_to :design_reviewed_by
  belongs_to :assembled_by
  belongs_to :shipped_by
  belongs_to :shipping_payment
end
