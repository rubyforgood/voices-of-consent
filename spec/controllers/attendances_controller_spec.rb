# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do
  has_authenticated_user

  let(:meeting) { create(:meeting) }

  let(:valid_attributes) do
    {
      meeting_id: meeting.id,
      user_id: subject.current_user.id,
      special_duties: 'special duties',
      completed_hours: 20
    }
  end

  let(:invalid_attributes) do
    { meeting_id: nil, user_id: subject.current_user.id, special_duties: '', completed_hours: nil }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Attendance.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, {}
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Attendance' do
        expect { post :create, params: { attendance: valid_attributes } }.to change(
          Attendance,
          :count
        ).by(1)
      end

      it 'redirects to the created attendance' do
        post :create, params: { attendance: valid_attributes }
        expect(response).to redirect_to(Attendance.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { attendance: invalid_attributes }
        expect(response).to be_successful
      end

      it 'does not create a new Attendance' do
        expect { post :create, params: { attendance: invalid_attributes } }.to change(
          Attendance,
          :count
        ).by(0)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          meeting_id: meeting.id,
          user_id: subject.current_user.id,
          special_duties: 'special duties string updated',
          completed_hours: 20
        }
      end

      it 'updates the requested attendance' do
        attendance = Attendance.create! valid_attributes
        put :update, params: { id: attendance.to_param, attendance: new_attributes }
        attendance.reload
        expect(response).to redirect_to(attendance)
        expect(attendance.special_duties).to eq('special duties string updated')
      end

      it 'redirects to the attendance' do
        attendance = Attendance.create! valid_attributes
        put :update, params: { id: attendance.to_param, attendance: valid_attributes }
        expect(response).to redirect_to(attendance)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        attendance = Attendance.create! valid_attributes
        put :update, params: { id: attendance.to_param, attendance: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested attendance' do
      attendance = Attendance.create! valid_attributes
      expect { delete :destroy, params: { id: attendance.to_param } }.to change(Attendance, :count)
        .by(-1)
    end

    it 'redirects to the attendances list' do
      attendance = Attendance.create! valid_attributes
      delete :destroy, params: { id: attendance.to_param }
      expect(response).to redirect_to(attendances_url)
    end
  end
end
