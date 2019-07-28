require 'rails_helper'

RSpec.describe BoxShipmentController, type: :controller do

  describe "GET #claim" do
    let!(:edgars_box) { create(:box) }
    let(:ship_permit) { create(:user_permission, :can_ship) }
    let(:box_shipper) { ship_permit.user }
    it "returns http success" do
      allow(request.env['warden']).to receive(:authenticate!).and_return(box_shipper)
      allow(controller).to receive(:current_user).and_return(box_shipper)

      get :claim, params: {box_id: edgars_box.id}
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
