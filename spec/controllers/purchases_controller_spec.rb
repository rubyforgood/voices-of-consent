# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  has_authenticated_user

  let(:other_user) { create(:user) }
  let(:new_location) { create(:location) }

  let(:valid_attributes) do
    {
      location_id: new_location.id,
      total_price: 20.0,
      purchased_by_id: subject.current_user.id,
      reimbursed_by_id: other_user.id,
      reimbursement_check_number: '12345',
      reimbursement_status: 'Not reimbursed'
    }
  end

  let(:invalid_attributes) do
    {
      location_id: nil,
      total_price: 20.0,
      purchased_by_id: nil,
      reimbursed_by_id: nil,
      reimbursement_check_number: '12345',
      reimbursement_status: 'Not reimbursed'
    }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Purchase.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Purchase' do
        expect { post :create, params: { purchase: valid_attributes } }.to change(Purchase, :count)
          .by(1)
      end

      it 'redirects to the created purchase' do
        post :create, params: { purchase: valid_attributes }
        expect(response).to redirect_to(Purchase.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { purchase: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          location_id: new_location.id,
          total_price: 20.0,
          purchased_by_id: subject.current_user.id,
          reimbursed_by_id: other_user.id,
          reimbursement_check_number: '12345',
          reimbursement_status: 'Reimbursed'
        }
      end

      it 'updates the requested purchase' do
        purchase = Purchase.create! valid_attributes
        put :update, params: { id: purchase.to_param, purchase: new_attributes }
        purchase.reload
        expect(flash[:notice]).to eq('Purchase was successfully updated.')
      end

      it 'redirects to the purchase' do
        purchase = Purchase.create! valid_attributes
        put :update, params: { id: purchase.to_param, purchase: valid_attributes }
        expect(response).to redirect_to(purchase)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        purchase = Purchase.create! valid_attributes
        put :update, params: { id: purchase.to_param, purchase: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested purchase' do
      purchase = Purchase.create! valid_attributes
      expect { delete :destroy, params: { id: purchase.to_param } }.to change(Purchase, :count).by(
        -1
      )
    end

    it 'redirects to the purchases list' do
      purchase = Purchase.create! valid_attributes
      delete :destroy, params: { id: purchase.to_param }
      expect(response).to redirect_to(purchases_url)
    end
  end
end
