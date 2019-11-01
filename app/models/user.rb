class User < ApplicationRecord
  include Messageable
  include Sendable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  belongs_to :volunteer

  has_one_attached :avatar
  has_many :user_permissions

  has_many :box_items_as_creator, class_name: "BoxItem", foreign_key: :created_by_id, inverse_of: :created_by, dependent: :restrict_with_error
  has_many :box_items_as_researcher, class_name: "BoxItem", foreign_key: :created_by_id, inverse_of: :created_by, dependent: :restrict_with_error
  has_many :box_items_as_updater, class_name: "BoxItem", foreign_key: :updated_by_id, inverse_of: :updated_by, dependent: :restrict_with_error
  has_many :box_requests_as_reviewer, class_name: "BoxRequest", foreign_key: :reviewed_by_id, inverse_of: :reviewed_by, dependent: :restrict_with_error
  has_many :boxes_as_designer, class_name: "Box", foreign_key: :designed_by_id, inverse_of: :designed_by, dependent: :restrict_with_error
  has_many :boxes_as_design_reviewer, class_name: "Box", foreign_key: :design_reviewed_by_id, inverse_of: :design_reviewed_by, dependent: :restrict_with_error
  has_many :boxes_as_researcher, class_name: "Box", foreign_key: :researched_by_id, inverse_of: :researched_by, dependent: :restrict_with_error
  has_many :boxes_as_assembler, class_name: "Box", foreign_key: :assembled_by_id, inverse_of: :assembled_by, dependent: :restrict_with_error
  has_many :boxes_as_shipper, class_name: "Box", foreign_key: :shipped_by_id, inverse_of: :shipped_by, dependent: :restrict_with_error
  has_many :boxes_as_followupper, class_name: "Box", foreign_key: :followed_up_by_id, inverse_of: :followed_up_by, dependent: :restrict_with_error
  has_many :message_logs_sent, class_name: "MessageLog", foreign_key: :sent_by_id, inverse_of: :sent_by, dependent: :nullify
  has_many :purchases, foreign_key: :purchased_by_id, inverse_of: :purchased_by, dependent: :restrict_with_error
  has_many :reimbursed_purchases, class_name: "Purchase", foreign_key: :reimbursed_by_id, inverse_of: :reimbursed_by, dependent: :restrict_with_error

  delegate :first_name, to: :volunteer
  delegate :name, to: :volunteer

  scope :permission,-> (permission_name){ joins(:user_permissions).where("user_permissions.permission ILIKE ?", "%#{permission_name}%") }

  def grant_all_permissions!
    Permission::AVAILABLE_PERMISSIONS.values.each do |permission|
      UserPermission.where(user: self, permission: permission).first_or_create!
    end
  end
end
