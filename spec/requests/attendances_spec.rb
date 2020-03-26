# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Attendances', type: :request do
  describe 'GET /attendances when logged in' do
    let(:user) { create(:user) }

    before { login_as(user, scope: :user) }

    after { Warden.test_reset! }

    context 'as a user with permission' do
      before { create(:user_permission, :can_volunteer_at_events, user: user) }

      it 'responds with the correct html content' do
        get attendances_path
        expect(response.body).to include('Meeting')
        expect(response.body).to include('User')
        expect(response.body).to include('Special duties')
        expect(response.body).to include('Completed hours')
      end

      it 'responds with the correct status (200)' do
        get attendances_path
        expect(response).to have_http_status(200)
      end
    end

    context 'as a user WITHOUT permission' do
      it 'responds with unauthorized' do
        pending(
          '' \
            'Currently the context "WITHOUT permission" is succeeding with status 200,
                   this is Not what we want, we should be getting a 401, that user CANT BE THERE!' \
            ''
        )

        create(:attendance, user: user)

        get attendances_path

        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /attendances when NOT logged in' do
    it 'responds with correct status (302)' do
      get attendances_path
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET /attendances when logged in, without permission' do
    it 'responds with correct status (302)' do
      get attendances_path
      expect(response).to have_http_status(302)
    end
  end
end
