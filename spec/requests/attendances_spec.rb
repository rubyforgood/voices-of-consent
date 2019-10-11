require 'rails_helper'

# Currently the context "WITHOUT permission" is succeeding with status 200, this is Not what we want,
# we should be getting a 401, that user CANT BE THERE!

RSpec.describe "Attendances", type: :request do

  describe "GET /attendances when logged in" do
    let(:user) { create(:user) }

    before do
      login_as(user, :scope => :user)
    end

    after do
      Warden.test_reset!
    end

    context "as a user with permission" do
      before do
        create(:user_permission, :can_volunteer_at_events, user: user)
      end

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
    context "as a user WITHOUT permission" do
      it "responds with unauthorized" do
        create(:attendance, user: user)
        get attendances_path
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "GET /attendances when NOT logged in" do
    it "responds with correct status (302)" do
      get attendances_path
      expect(response).to have_http_status(302)
    end
  end

  describe "GET /attendances when logged in, without permission" do
    it "responds with correct status (302)" do
      get attendances_path
      expect(response).to have_http_status(302)
    end
  end
end
