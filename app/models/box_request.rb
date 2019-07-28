class BoxRequest < ApplicationRecord
  belongs_to :requester
  belongs_to :reviewed_by, class_name: 'User', optional: true
  has_one :box
  include Messageable

  validates :requester, presence: true
  validates :question_re_affect, presence: true
  validates :question_re_referral_source, presence: true
  validates :question_re_current_situation, presence: true

  acts_as_taggable

  delegate :designer_name, :assembler_name, :shipper_name, :followup_sent?, to: :box, allow_nil: true
  delegate :name, to: :reviewed_by, prefix: :reviewer, allow_nil: true
end
