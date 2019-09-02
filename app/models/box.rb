class Box < ApplicationRecord
  include AASM


  belongs_to :box_request
  belongs_to :designed_by, optional: true, class_name: "User", foreign_key: :designed_by_id, inverse_of: :boxes_as_designer
  belongs_to :design_reviewed_by, optional: true, class_name: "User", foreign_key: :design_reviewed_by_id, inverse_of: :boxes_as_design_reviewer
  belongs_to :assembled_by, optional: true, class_name: "User", foreign_key: :assembled_by_id, inverse_of: :boxes_as_assembler
  belongs_to :shipped_by, optional: true, class_name: "User", foreign_key: :shipped_by_id, inverse_of: :boxes_as_shipper
  belongs_to :shipping_payment, optional: true, class_name: "Purchase", foreign_key: :shipping_payment_id, inverse_of: :payment_for_shipment

  has_many :box_items

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

  aasm do
    
    state :pending_review, :initial => true
    state :design_in_progress
    state :designed
    state :assembly_in_progress
    state :assembled 
    state :shipping_in_progress
    state :shipped

    after_all_transitions :log_status_change

    event :initialize_design, :before => :check_state  do
      transitions :from => :pending_review, :to => :design_in_progress, :guard => :request_reviewed
    end

    event :design do
      transitions :from => :design_in_progress, :to => :designed, :guard => :is_designed
    end

    event :assembling do
      transitions :from => :designed, :to => :assembly_in_progress, :guard => :has_assembler_id
    end

    event :assemble do
      transitions :from => :assembly_in_progress, :to => :assembled, :guard => :is_assembled
    end

    event :shipping do
      transitions :from => :assembled, :to => :shipping_in_progress, :guard => :has_shipper_id
    end

    event :ship do
      transitions :from => :shipping_in_progress, :to => :shipped, :guard => :is_shipped
    end

  end

    def check_state
      self.aasm_state = 'pending_review'
    end

    def request_reviewed
      box_request.aasm_state = 'reviewed'
    end

    def has_designer_id
      !self.designed_by_id.nil?
    end

    def is_designed
      self.assembled_by_id.nil? && !self.designed_at.nil?
    end

     def has_assembler_id
      !self.assembled_by_id.nil?
    end

     def is_assembled
      box_items.pluck(:added_to_box).all?
    end

    def has_shipper_id
      !self.shipped_by_id.nil?
    end

    def is_shipped
      !self.shipped_at.nil?
    end

    def log_status_change
      puts "Changed from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
    end


end
