require 'rails_helper'

RSpec.describe "BoxRequestAbuseTypes", type: :request do

  let(:user) { create(:user) }

  before do
    login_as(user, :scope => :user)
  end

  after do
    Warden.test_reset!
  end

  describe "GET /box_request_abuse_types" do
    it "works! (now write some real specs)" do
      get box_request_abuse_types_path
      expect(response).to have_http_status(200)
    end
  end
end
