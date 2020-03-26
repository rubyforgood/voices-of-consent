# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Purchases', type: :request do
  let(:user) { create(:user) }

  before { login_as(user, scope: :user) }

  after { Warden.test_reset! }

  describe 'GET /purchases' do
    it 'works! (now write some real specs)' do
      get purchases_path
      expect(response).to have_http_status(200)
    end
  end
end
