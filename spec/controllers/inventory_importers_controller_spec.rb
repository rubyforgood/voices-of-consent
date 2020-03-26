# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InventoryImportsController, type: :controller do
  has_authenticated_user

  let(:valid_params) do
    {
      import_file: fixture_file_upload('files/inventory_tally.csv', 'text/csv')
    }
  end

  let(:invalid_params) do
    {
      import_file:
        fixture_file_upload('files/inventory_tally_malformed.csv', 'text/csv')
    }
  end

  let(:valid_session) { {} }

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates new InventoryTally objects' do
        expect do
          post :create, params: valid_params, session: valid_session
        end.to change(InventoryTally, :count).by(4)
      end

      it 'redirects to the inventory tally index' do
        post :create, params: valid_params, session: valid_session
        expect(response).to redirect_to(inventory_tallies_path)
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        post :create, params: invalid_params, session: valid_session
        expect(response).to be_successful
      end

      it 'does not create inventory tallies' do
        expect do
          post :create, params: invalid_params, session: valid_session
        end.not_to change(InventoryTally, :count)
      end
    end
  end
end
