require 'rails_helper'

RSpec.describe "Attendances", type: :request do
  describe "GET /attendances" do
    it "works! (now write some real specs)" do
      get attendances_path
      expect(response).to have_http_status(200)
    end
  end
end
