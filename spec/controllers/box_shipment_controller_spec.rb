require 'rails_helper'

RSpec.describe BoxShipmentController, type: :controller do

  describe "GET #claim" do
    let!(:box) { Box.create }

    it "returns http success" do
      get :claim, params: {box_id: 42}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #mark_as_shipped" do
    it "returns http success" do
      get :mark_as_shipped
      expect(response).to have_http_status(:success)
    end
  end

end
