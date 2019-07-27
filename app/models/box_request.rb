class BoxRequest < ApplicationRecord
  belongs_to :requester
  include Messageable

  validates :requester, presence: true
  validates :summary, presence: true
  validates :question_re_affect, presence: true
  validates :question_re_referral_source, presence: true
  validates :question_re_current_situation, presence: true

  acts_as_taggable
end
