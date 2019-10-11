require 'rails_helper'

RSpec.describe BoxAssemblyController, type: :controller do
  has_authenticated_user

  let(:box) { create(:box) }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
