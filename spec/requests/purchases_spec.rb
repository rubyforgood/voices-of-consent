require 'rails_helper'

RSpec.describe "Purchases", type: :request do
  describe "GET /purchases" do
    it "works! (now write some real specs)" do
      get purchases_path
      expect(response).to have_http_status(200)
    end
  end
end
