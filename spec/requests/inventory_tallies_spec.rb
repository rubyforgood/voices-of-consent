require 'rails_helper'

RSpec.describe "InventoryTallies", type: :request do
  describe "GET /inventory_tallies" do
    it "works! (now write some real specs)" do
      get inventory_tallies_path
      expect(response).to have_http_status(200)
    end
  end
end
