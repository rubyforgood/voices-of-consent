class UserPermission < ApplicationRecord
  belongs_to :user
  validates :permission, presence: true
end
