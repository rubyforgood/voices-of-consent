require 'rails_helper'

RSpec.describe UserManagementController, type: :controller do
  has_authenticated_user

  describe "GET #index" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end
end
