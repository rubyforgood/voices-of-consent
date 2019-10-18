require 'rails_helper'

RSpec.describe "MessageLogs", type: :request do

  let(:user) { create(:user) }

  before do
    login_as(user, :scope => :user)
  end

  after do
    Warden.test_reset!
  end

  describe "GET /message_logs" do
    it "works! (now write some real specs)" do
      get message_logs_path
      expect(response).to have_http_status(200)
    end
  end
end
