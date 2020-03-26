# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes'

  describe '#grant_all_permissions!' do
    it 'ensures a user has all available permissions' do
      user = create(:user)
      expect(user.user_permissions.count).to eq(0)

      user.grant_all_permissions!
      expect(user.user_permissions.count).to eq(
        Permission::AVAILABLE_PERMISSIONS.count
      )
    end

    it "doesn't create any duplicative permissions" do
      user_permission = create(:user_permission, :can_ship)
      user = user_permission.user

      user.grant_all_permissions!
      expect(
        user.user_permissions.where(permission: user_permission.permission)
          .count
      ).to eq(1)
    end
  end
end
