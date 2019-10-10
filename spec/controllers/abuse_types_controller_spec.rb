require 'rails_helper'

RSpec.describe AbuseTypesController, type: :controller do
  has_authenticated_user

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { format: :json }

      expect(response).to be_successful
    end
  end
end
