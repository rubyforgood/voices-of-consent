require 'rails_helper'

RSpec.describe "Attendances", type: :request do

  describe "GET /attendances" do

    before do
      user = FactoryBot.create(:user)
      login_as(user, :scope => :user)
    end

    after { Warden.test_reset! }

    it "responds with the correct html content" do
      get attendances_path
      expect(response.body).to include("Meeting")
      expect(response.body).to include("User")
      expect(response.body).to include("Special duties")
      expect(response.body).to include("Completed hours")
    end

    it "responds with the correct status (200)" do
      get attendances_path
      expect(response).to have_http_status(200)
    end
  end
end
