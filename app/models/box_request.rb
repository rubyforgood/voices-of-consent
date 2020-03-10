class BoxRequest < ApplicationRecord
  include AASM

  include Messageable
  acts_as_taggable

  belongs_to :requester
  belongs_to :reviewed_by, optional: true, class_name: "User", foreign_key: :reviewed_by_id, inverse_of: :box_requests_as_reviewer
  has_many :box_request_abuse_types
  has_one :box

  validates :requester, presence: true
  validates :question_re_affect, presence: true
  validates :question_re_referral_source, presence: true
  validates :question_re_current_situation, presence: true

  delegate :first_name, to: :reviewed_by, prefix: :reviewer, allow_nil: true
  delegate :name, to: :reviewed_by, prefix: :reviewer, allow_nil: true

  scope :requested, ->(){ where(reviewed_by_id: nil) }
  scope :designed, ->(){ joins(:box).where("boxes.aasm_state = ?", "designed") }
  scope :design_in_progress, ->(){ joins(:box).where("boxes.aasm_state = ?", "design_in_progress") }
  scope :assembly_in_progress, ->(){ joins(:box).where("boxes.aasm_state = ?", "assembly_in_progress") }
  scope :assembled, ->(){ joins(:box).where("boxes.aasm_state = ?", "assembled") }
  scope :shipping_in_progress, ->(){ joins(:box).where("boxes.aasm_state = ?", "shipping_in_progress") }
  scope :shipped, ->(){ joins(:box).where("boxes.aasm_state = ?", "shipped") }
  scope :research_in_progress, ->(){ joins(:box).where("boxes.aasm_state = ?", "research_in_progress") }
  scope :researched, ->(){ joins(:box).where("boxes.aasm_state = ?", "researched") }
  scope :follow_up_in_progress, ->(){ joins(:box).where("boxes.aasm_state = ?", "follow_up_in_progress") }
  scope :followed_up, ->(){ joins(:box).where("boxes.aasm_state = ?", "followed_up") }

  aasm do

    state :requested, :initial => true
    state :review_in_progress
    state :reviewed

    after_all_transitions :log_status_change

    event :claim_review do
      transitions :from => :requested, :to => :review_in_progress, :guard => :check_reviewer
    end

    event :complete_review, :before => :mark_as_reviewed! do
      transitions :from => :review_in_progress, :to => :reviewed, :guard => :is_reviewed
    end

  end

    def name
      "#{requester.city}, #{requester.state} (#{tag_list.to_sentence})"
    end

    def is_reviewed
      self.box && !self.reviewed_at.nil?
    end

    def check_reviewer
      !reviewed_by_id.nil?
    end

    def create_associated_box
      unless box
        Box.create(box_request: self)
      end

      if box.box_items.none?
        box.create_core_box_items!
      end
    end

    def update_reviewed_at!
      update_attributes(reviewed_at: Time.now)
    end

    def mark_as_reviewed!
      update_reviewed_at!
      create_associated_box
    end

    def decline_review!
      self.review_declined_by_ids << current_user.id
      self.save!
    end

    def log_status_change
      puts "Changed from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
    end


end
