require 'rails_helper'

RSpec.describe "MeetingTypes", type: :request do
  describe "GET /meeting_types" do
    it "works! (now write some real specs)" do
      get meeting_types_path
      expect(response).to have_http_status(200)
    end
  end
end
