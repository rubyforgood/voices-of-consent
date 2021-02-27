require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  let!(:feedback) { create(:feedback) }
  render_views

  describe 'with admin user authenticated' do
    has_authenticated_admin_user

    context 'GET #index' do
      before do
        get :index, params: {}
      end

      it 'must have a successful http status code' do
        expect(response).to be_successful
      end

      it 'must have the feedback category in table' do
        expect(response.body).to include(feedback.category)
      end

      it 'must have the feedback type in table' do
        expect(response.body).to include(feedback.type)
      end
    end

    context 'GET #show' do
      before do
        get :show, params: { id: feedback.id }
      end

      it 'must have a successful http status code' do
        expect(response).to be_successful
      end

      it 'must have the feedback category in table' do
        expect(response.body).to include(feedback.category)
      end

      it 'must have the feedback type in table' do
        expect(response.body).to include(feedback.type)
      end
    end
  end

  describe 'when authenticated user is not admin' do
    has_authenticated_common_user

    context 'GET #index' do
      subject { get :index, params: {} }
      it 'must redirect to root' do
        expect(subject).to redirect_to(root_path)
      end
    end

    context 'GET #show' do
      subject { get :show, params: { id: feedback.id } }
      it 'must redirect to root' do
        expect(subject).to redirect_to(root_path)
      end
    end
  end
end
