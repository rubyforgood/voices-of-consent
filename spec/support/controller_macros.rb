# frozen_string_literal: true

module ControllerMacros
  def has_authenticated_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      user
    end
  end
end
