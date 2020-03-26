# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessageLogsController, type: :controller do
  has_authenticated_user

  # This should return the minimal set of attributes required to create a valid
  # MessageLog. As you add validations to MessageLog, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MessageLogsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      MessageLog.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #index page 2 & will_paginate records for second page' do
    it 'shows 2 items on the second page' do
      FactoryBot.create_list(
        :message_log,
        32,
        messageable: build(:volunteer), sendable: build(:volunteer)
      )
      get :index, params: { page: 2 }, session: valid_session
      expect(response).to be_successful
      # Only the last two items are rendered on the second page
      expect(@controller.instance_variable_get(:@message_logs).length).to eq(2)
      expect(MessageLog.count).to eq(32)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      message_log = MessageLog.create! valid_attributes
      get :show, params: { id: message_log.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      message_log = MessageLog.create! valid_attributes
      get :edit, params: { id: message_log.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new MessageLog' do
        expect do
          post :create,
               params: { message_log: valid_attributes }, session: valid_session
        end.to change(MessageLog, :count).by(1)
      end

      it 'redirects to the created message_log' do
        post :create,
             params: { message_log: valid_attributes }, session: valid_session
        expect(response).to redirect_to(MessageLog.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create,
             params: { message_log: invalid_attributes }, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested message_log' do
        message_log = MessageLog.create! valid_attributes
        put :update,
            params: { id: message_log.to_param, message_log: new_attributes },
            session: valid_session
        message_log.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the message_log' do
        message_log = MessageLog.create! valid_attributes
        put :update,
            params: { id: message_log.to_param, message_log: valid_attributes },
            session: valid_session
        expect(response).to redirect_to(message_log)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        message_log = MessageLog.create! valid_attributes
        put :update,
            params: {
              id: message_log.to_param, message_log: invalid_attributes
            },
            session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested message_log' do
      message_log = MessageLog.create! valid_attributes
      expect do
        delete :destroy,
               params: { id: message_log.to_param }, session: valid_session
      end.to change(MessageLog, :count).by(-1)
    end

    it 'redirects to the message_logs list' do
      message_log = MessageLog.create! valid_attributes
      delete :destroy,
             params: { id: message_log.to_param }, session: valid_session
      expect(response).to redirect_to(message_logs_url)
    end
  end
end
