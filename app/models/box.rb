class Box < ApplicationRecord
  include AASM
  include Messageable

  belongs_to :box_request
  belongs_to :designed_by, optional: true, class_name: "User", foreign_key: :designed_by_id, inverse_of: :boxes_as_designer
  belongs_to :design_reviewed_by, optional: true, class_name: "User", foreign_key: :design_reviewed_by_id, inverse_of: :boxes_as_design_reviewer
  belongs_to :researched_by, optional: true, class_name: "User", foreign_key: :researched_by_id, inverse_of: :boxes_as_researcher
  belongs_to :assembled_by, optional: true, class_name: "User", foreign_key: :assembled_by_id, inverse_of: :boxes_as_assembler
  belongs_to :shipped_by, optional: true, class_name: "User", foreign_key: :shipped_by_id, inverse_of: :boxes_as_shipper
  belongs_to :shipping_payment, optional: true, class_name: "Purchase", foreign_key: :shipping_payment_id, inverse_of: :shipments
  belongs_to :followed_up_by, optional: true, class_name: "User", foreign_key: :followed_up_by_id, inverse_of: :boxes_as_followupper

  has_many :box_items

  delegate :first_name, to: :designed_by, prefix: :designer, allow_nil: true
  delegate :first_name, to: :assembled_by, prefix: :assembler, allow_nil: true
  delegate :first_name, to: :shipped_by, prefix: :shipper, allow_nil: true

  def has_designer?
    return !self.designed_by.nil?
  end

  def has_researcher?
    return !self.researched_by.nil?
  end

  def has_assembler?
    return !self.assembled_by.nil?
  end

  def has_shipper?
    return !self.shipped_by.nil?
  end

  def has_follow_upper?
    return !self.followed_up_by.nil?
  end

  aasm do

    state :reviewed, :initial => true
    state :design_in_progress
    state :designed
    state :research_in_progress
    state :researched
    state :assembly_in_progress
    state :assembled
    state :shipping_in_progress
    state :shipped
    state :follow_up_in_progress
    state :followed_up

    after_all_transitions :log_status_change

    event :claim_design, before: :check_state  do
      transitions :from => :reviewed, :to => :design_in_progress, :guard => :is_reviewed
    end

    event :complete_design, before: [:check_has_box_items, :update_designed_at!] do
      transitions :from => :design_in_progress, :to => :designed,   :if => :check_if_research_is_needed, :guard => :is_designed, after: :send_research_solicitation_email!
      transitions :from => :design_in_progress, :to => :researched, :guard => [:is_designed], after: :send_assembly_solicitation_email!
    end

    event :claim_research, before: :check_if_research_is_needed do
      transitions :from => :designed, :to => :researched,           :if => :is_researched, :guard => :is_researched
      transitions :from => :designed, :to => :research_in_progress, :guard => :has_researcher_id
    end

    event :complete_research, before: [:check_was_researched, :update_researched_at!] do
      transitions :from => :research_in_progress, :to => :researched, :if => :check_if_research_is_needed
      transitions :from => :research_in_progress, :to => :researched, :guard => :is_researched
    end

    event :claim_assembly do
      transitions :from => :researched, :to => :assembly_in_progress, :guard => :has_assembler_id
    end

    event :complete_assembly, before: [:add_box_items_to_box, :update_assembled_at!], after: :send_shipping_solicitation_email! do
      transitions :from => :assembly_in_progress, :to => :assembled, :guard => :is_assembled
    end

    event :claim_shipping do
      transitions :from => :assembled, :to => :shipping_in_progress, :guard => :has_shipper_id
    end

    event :complete_shipping, before: :update_shipped_at! do
      transitions :from => :shipping_in_progress, :to => :shipped, :guard => :is_shipped
    end

    event :claim_follow_up do
      transitions :from => :shipped, :to => :follow_up_in_progress, :guard => :has_followed_up_by_id
    end

    event :complete_follow_up, before: :update_followed_up_at! do
      transitions :from => :follow_up_in_progress, :to => :followed_up, :guard => :is_followed_up
    end

  end

    def check_state
      self.aasm_state = 'reviewed'
    end

    def check_has_box_items
      # TODO - add block in UI to not allow button to box_design/:id/complete if no associated items
      if box_items.any?
        true
      else
        self.create_core_box_items!
        true
      end
    end

    def add_box_items_to_box
      # box_items.map(&:added_to_box).none?
      # TODO - make this happen via AJAX when filling out checklist and then remove it from :complete_assembly and def is_assembled
      box_items.each do |box_item|
        box_item.add_to_box!
      end
      true
    end

    def check_if_research_is_needed
      if box_items_require_research?
        true # stay in research state
      else
        mark_as_researched! # marks as "researched" since no research is needed
        false
      end
    end

    def mark_box_items_as_researched! # TODO - remove this as always happening!
      box_items.each do |box_item|
        box_item.update_attributes(researched_at: Time.now,
                                   researched_by_id: researched_by_id || designed_by_id)
      end
    end

    def mark_as_researched!
      update_attributes(researched_at: Time.now,
                        researched_by_id: researched_by_id || designed_by_id)
    end

    def check_was_researched
      box_item_research_completed? # box_items.map{|bi| bi.file_uploads.any? }.all? TODO - need to build UI for researching BoxItems
    end

    def has_designer_id
      !self.designed_by_id.nil?
    end

    def has_researcher_id
      !self.researched_by_id.nil?
    end

    def has_assembler_id
      !self.assembled_by_id.nil?
    end

    def has_followed_up_by_id
      !self.followed_up_by_id.nil?
    end

    def has_shipper_id
      !self.shipped_by_id.nil?
    end

    def is_reviewed
      box_request.aasm_state = 'reviewed' && box_request.reviewed_by_id && box_request.reviewed_at.present?
    end

    def is_designed
      self.designed_by_id && self.designed_at.present?
    end

    def is_researched
      self.researched_by_id && self.researched_at.present? && box_item_research_completed?
    end

    def is_assembled
      self.assembled_by_id && self.assembled_at.present? && box_items.any? && box_items.pluck(:added_to_box).all?
    end

    def is_shipped
      self.shipped_by_id && self.shipped_at.present?
    end

    def is_followed_up
      self.followed_up_by_id && self.followed_up_at.present?
    end

    def box_items_require_research?
      box_items.map(&:requires_research).any?
    end

    def box_item_research_completed?
      if box_items.map(&:requires_research).any?
        research_status = []
        box_items.each do |box_item|
          if box_item.requires_research
            research_status << box_item.researched_by_id.present? && box_item.researched_at ? true : false
          end
        end
        research_status.all?
      else
        true
      end
    end

    def update_designed_at!
      update_attributes(designed_at: Time.now)
    end

    def update_assembled_at!
      update_attributes(assembled_at: Time.now)
    end

    def update_design_reviewed_at!
      update_attributes(design_reviewed_at: Time.now)
    end

    def update_researched_at!
      update_attributes(researched_at: Time.now)
    end

    def update_followed_up_at!
      update_attributes(followed_up_at: Time.now)
    end

    def update_shipped_at!
      update_attributes(shipped_at: Time.now)
    end

    def log_status_change
      puts "Changed from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
    end

    def decline_design!
      self.design_declined_by_ids << current_user.id
      self.save!
    end

    def decline_research!
      self.research_declined_by_ids << current_user.id
      self.save!
    end

    def decline_assembly!
      self.assembly_declined_by_ids << current_user.id
      self.save!
    end

    def decline_shipping!
      self.shipping_declined_by_ids << current_user.id
      self.save!
    end

    def decline_follow_up!
      self.followup_declined_by_ids << current_user.id
      self.save!
    end

    def create_core_box_items!
      box_request.box_request_abuse_types.each do |box_request_abuse_type|
        CoreBoxItem.where(abuse_type: box_request_abuse_type.abuse_type).each do |core_box_item|
          BoxItem.where(box: self,
                        inventory_type: core_box_item.inventory_type).
              first_or_create!(created_by: box_request.reviewed_by,
                               updated_by: box_request.reviewed_by)
        end
      end
    end

    def send_research_solicitation_email!
      AutoEmailHandler.new("volunteer", self, self.designed_by)
    end

    def send_assembly_solicitation_email!
      AutoEmailHandler.new("volunteer", self, self.researched_by)
    end

    def send_shipping_solicitation_email!
      AutoEmailHandler.new("volunteer", self, self.assembled_by)
    end
end
