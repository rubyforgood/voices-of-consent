class BoxRequest < ApplicationRecord
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
end
