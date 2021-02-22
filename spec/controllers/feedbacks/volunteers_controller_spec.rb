require 'rails_helper'

RSpec.describe Feedbacks::VolunteersController, type: :controller do

  describe 'GET #index' do
    it 'returns a success response' do
      get :new

      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    subject(:post_request) { post :create, params: request_params }
    let(:response_json) { JSON.parse(response.body)}

    before do
      post_request
    end

    context 'with valid params' do
      let(:request_params) { { feedback: { description: 'Some feedback description', category: Feedback::CATEGORIES.sample }  } }
      
      it 'should have a created response code' do
        expect(response).to have_http_status(:created)
      end

      it 'must have the success message' do
        expect(response_json.symbolize_keys).to eq({ message: 'Feedback was succesfull created, thank you!' })
      end
    end

    context 'with invalid params' do
      let(:request_params) { { feedback: { description: '', category: 'Not valid category' } } }

      it 'should have an unprocessable entity response code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must include the errors' do
        wrong_feedback = Feedbacks::Volunteer.new(request_params[:feedback])
        wrong_feedback.save

        expect(response.body).to eq(wrong_feedback.errors.to_json)
      end
    end
  end 
end
