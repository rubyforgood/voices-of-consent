require 'rails_helper'

RSpec.describe BoxShipmentController, type: :controller do
  has_authenticated_user

  let(:ship_permit) { create(:user_permission, :can_ship) }
  let(:box_shipper) { ship_permit.user }
  let!(:edgars_box) { create(:box, :shipped_by => box_shipper) }

  before do
    allow(request.env['warden']).to receive(:authenticate!).and_return(box_shipper)
    allow(subject).to receive(:current_user).and_return(box_shipper)
    allow(subject).to receive(:box_claim_scope).and_return(Box)
    allow(Box).to receive(:find).and_return(edgars_box)
  end

  describe "GET #claim" do
    it "returns http success" do
      get :claim, params: {box_id: edgars_box.id}

      expect(response).to redirect_to(box_request_claim_thank_you_path(edgars_box.box_request, "assemble"))
    end
  end

  describe "GET #complete" do
    it "returns http success" do
      allow(edgars_box).to receive(:aasm_state)
      allow(edgars_box).to receive(:save).and_return(true)

      get :complete, :params => {:box_id => edgars_box.id}

      expect(response).to redirect_to(box_requests_path)
    end
  end
end
