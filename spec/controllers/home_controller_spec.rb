require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    let(:user) { create(:user) }

    before do
      sign_in(user)
    end

    context "when no params are passed" do
      it "returns a success response" do
        get :index
        expect(response).to be_successful
      end

      it "calls inventory date filter with the correct params" do
        expect(InventoryDateFilter).to receive(:call).and_call_original
        get :index
      end

      it "calls presenter with the correct params" do
        expect(InventoryDashboardPresenter).to receive(:new).with({})
        get :index
      end
    end

    context "when start_date" do
      let(:start_date) { Date.today }

      before do
        create(:box_request, created_at: start_date)
        create(:box, created_at: start_date)
      end

      let(:start_date_params) do
        {
          inventory: {
            start_date: start_date.to_s
          }
        }
      end

      it "returns a success response" do
        get :index, params: start_date_params
        expect(response).to be_successful
      end

      it "calls inventory date filter with the correct params" do
        expect(InventoryDateFilter).to receive(:call).with({ inventory: { start_date: start_date.to_s }}).and_call_original
        get :index, params: start_date_params
      end

      it "calls presenter with the correct params" do
        expect(InventoryDashboardPresenter).to receive(:new).with({ start_date: start_date.to_s })
        get :index, params: start_date_params
      end
    end

    context "when end_date" do
      let(:end_date) { Date.today }

      before do
        create(:box_request, created_at: end_date)
        create(:box, created_at: end_date)
      end

      let(:end_date_params) do
        {
          inventory: {
            end_date: end_date.to_s
          }
        }
      end

      it "returns a success response" do
        get :index, params: end_date_params
        expect(response).to be_successful
      end

      it "calls inventory date filter with the correct params" do
        expect(InventoryDateFilter).to receive(:call).with({ inventory: { end_date: end_date.to_s }}).and_call_original
        get :index, params: end_date_params
      end

      it "calls presenter with the correct params" do
        expect(InventoryDashboardPresenter).to receive(:new).with({ end_date: end_date.to_s, start_date: Date.today.to_s })
        get :index, params: end_date_params
      end
    end

    context "when start_date and end_date" do
      let(:start_date) { Date.today }
      let(:end_date) { Date.today }

      before do
        create(:box_request, created_at: start_date)
        create(:box_request, created_at: end_date)
        create(:box, created_at: start_date)
        create(:box, created_at: end_date)
      end

      let(:start_end_params) do
        {
          inventory: {
            start_date: start_date.to_s,
            end_date: end_date.to_s
          }
        }
      end

      it "returns a success response" do
        get :index, params: start_end_params
        expect(response).to be_successful
      end

      it "calls inventory date filter with the correct params" do
        expect(InventoryDateFilter).to receive(:call).with(
          { inventory:
            { start_date: start_date.to_s, end_date: end_date.to_s }
          }).and_call_original
        get :index, params: start_end_params
      end

      it "calls presenter with the correct params" do
        expect(InventoryDashboardPresenter).to receive(:new).with(
          { start_date: start_date.to_s, end_date: end_date.to_s })
        get :index, params: start_end_params
      end
    end
  end
end
