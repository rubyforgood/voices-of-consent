class User < ApplicationRecord
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  include Messageable

  has_many :message_logs_sent, class_name: "MessageLog", foreign_key: :sent_by_id, inverse_of: :sent_by, dependent: :nullify
  has_many :message_logs_received, class_name: "MessageLog", foreign_key: :sent_to_id, inverse_of: :sent_to, dependent: :nullify
  has_many :boxes_as_designer, class_name: "Box", foreign_key: :designed_by_id, inverse_of: :designed_by, dependent: :restrict_with_error
  has_many :boxes_as_design_reviewer, class_name: "Box", foreign_key: :design_reviewed_by_id, inverse_of: :designed_reviewed_by, dependent: :restrict_with_error
  has_many :boxes_as_assembler, class_name: "Box", foreign_key: :assembled_by_id, inverse_of: :assembled_by, dependent: :restrict_with_error
  has_many :boxes_as_shipper, class_name: "Box", foreign_key: :shipped_by_id, inverse_of: :shipped_by, dependent: :restrict_with_error
  has_many :purchases, foreign_key: :purchased_by_id, inverse_of: :purchased_by, dependent: :restrict_with_error
  has_many :reimbursed_purchases, class_name: "Purchase", foreign_key: :reimbursed_by_id, inverse_of: :reimbursed_by, dependent: :restrict_with_error

  has_one :volunteer
end
