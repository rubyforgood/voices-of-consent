class BoxRequest < ApplicationRecord
  include AASM

  include Messageable
  acts_as_taggable

  belongs_to :requester
  belongs_to :reviewed_by, optional: true, class_name: "User", foreign_key: :reviewed_by_id, inverse_of: :box_requests_as_reviewer
  has_one :box

  validates :requester, presence: true
  validates :question_re_affect, presence: true
  validates :question_re_referral_source, presence: true
  validates :question_re_current_situation, presence: true

  delegate :designer_name, :assembler_name, :shipper_name, :followup_sent?, to: :box, allow_nil: true
  delegate :name, to: :reviewed_by, prefix: :reviewer, allow_nil: true



  aasm do

    state :requested, :initial => true
    state :review_in_progress
    state :reviewed

    after_all_transitions :log_status_change

    event :review do
      transitions :from => :requested, :to => :review_in_progress, :guard => :check_reviewer
    end

    event :end_review, :after => :initialize_design do
      transitions :from => :review_in_progress, :to => :reviewed, :guard => :is_reviewed
    end

  end

    def is_reviewed
      self.box &&
      !self.reviewed_at.nil?
    end

    def check_reviewer
      !reviewed_by_id.nil?
    end

    def initialize_design
      box.initialize_design
    end


    def log_status_change
      puts "Changed from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
    end


end
