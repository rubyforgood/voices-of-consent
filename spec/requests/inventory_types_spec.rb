require 'rails_helper'

RSpec.describe "InventoryTypes", type: :request do
  describe "GET /inventory_types" do
    it "works! (now write some real specs)" do
      get inventory_types_path
      expect(response).to have_http_status(200)
    end
  end
end
