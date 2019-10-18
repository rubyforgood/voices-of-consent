require 'rails_helper'

RSpec.describe "Locations", type: :request do

  let(:user) { create(:user) }

  before do
    login_as(user, :scope => :user)
  end

  after do
    Warden.test_reset!
  end

  describe "GET /locations" do
    it "works! (now write some real specs)" do
      get locations_path
      expect(response).to have_http_status(200)
    end
  end
end
