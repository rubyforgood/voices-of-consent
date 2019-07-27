class User < ApplicationRecord
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boxes_as_designer, class_name: "Box", foreign_key: :designed_by_id, inverse_of: :designed_by, dependent: :nullify
  has_many :boxes_as_design_reviewer, class_name: "Box", foreign_key: :design_reviewed_by_id, inverse_of: :designed_reviewed_by, dependent: :nullify
  has_many :boxes_as_assembler, class_name: "Box", foreign_key: :assembled_by_id, inverse_of: :assembled_by, dependent: :nullify
  has_many :boxes_as_shipper, class_name: "Box", foreign_key: :shipped_by_id, inverse_of: :shipped_by, dependent: :nullify
end
