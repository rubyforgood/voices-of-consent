class Box < ApplicationRecord
  belongs_to :box_request
  belongs_to :designed_by, optional: true, class_name: "User", foreign_key: :designed_by_id, inverse_of: :boxes_as_designer
  belongs_to :design_reviewed_by, optional: true, class_name: "User", foreign_key: :design_reviewed_by_id, inverse_of: :boxes_as_design_reviewer
  belongs_to :assembled_by, optional: true, class_name: "User", foreign_key: :assembled_by_id, inverse_of: :boxes_as_assembler
  belongs_to :shipped_by, optional: true, class_name: "User", foreign_key: :shipped_by_id, inverse_of: :boxes_as_shipper
  belongs_to :shipping_payment, optional: true, class_name: "Purchase", foreign_key: :shipping_payment_id, inverse_of: :payment_for_shipment

  delegate :name, to: :designed_by, prefix: :designer, allow_nil: true
  delegate :name, to: :assembled_by, prefix: :assembler, allow_nil: true
  delegate :name, to: :shipped_by, prefix: :shipper, allow_nil: true

  def has_designer?
    return !self.designed_by.nil?
  end

  def has_assembler?
    return !self.assembled_by.nil?
  end
  
  def has_shipper?
    return !self.shipped_by.nil?
  end

  def followup_sent?
    false
  end
end
