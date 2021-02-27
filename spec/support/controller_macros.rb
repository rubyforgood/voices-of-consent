module ControllerMacros
  def has_authenticated_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      user
    end
  end

  def has_authenticated_admin_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = create(:user)
      create(:user_permission, user: user, permission: 'manage users')

      sign_in user
    end
  end

  def has_authenticated_common_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = create(:user)
      create(:user_permission,
             user: user,
             permission: Permission::AVAILABLE_PERMISSIONS.map { |_key, value| value }.sample)

      sign_in user
    end
  end
end
