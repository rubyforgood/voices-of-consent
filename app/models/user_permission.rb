# frozen_string_literal: true

class UserPermission < ApplicationRecord
  belongs_to :user
  validates :permission, presence: true
end
