require 'rails_helper'

RSpec.describe "InventoryAdjustments", type: :request do
  describe "GET /inventory_adjustments" do
    it "works! (now write some real specs)" do
      get inventory_adjustments_path
      expect(response).to have_http_status(200)
    end
  end
end
