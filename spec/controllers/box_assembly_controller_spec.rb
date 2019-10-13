require 'rails_helper'

RSpec.describe BoxAssemblyController, type: :controller do
  has_authenticated_user

  let(:box) { build_stubbed(:box) }

  describe "GET #new" do
    it "returns http success" do
      box_claim_scope = double('scope')
      allow(subject).to receive(:box_claim_scope).and_return(box_claim_scope)
      allow(box_claim_scope).to receive(:find).and_return(box)

      get :new, :params => {:box_id => box.id}

      expect(response).to have_http_status(:success)
    end
  end
end
