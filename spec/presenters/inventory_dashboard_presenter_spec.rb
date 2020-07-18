require 'rails_helper'

RSpec.describe InventoryDashboardPresenter do
  let(:date) { Date.today }

  context "calls the correct function" do
    it "#initialize" do
      expect(subject.start_date).to eq(date)
      expect(subject.start_date).to eq(date)
    end

    it "#total_box_requests with no params" do
      expect(BoxRequestsQuery.call).to be(0)
    end

    it "#total_box_requests with params" do
      expect(BoxRequestsQuery.call(start_date: date, end_date: date)).to be(0)
    end

    it "#total_box_shipped with no params" do
      expect(BoxShippedQuery.call).to be(0)
    end

    it "#total_box_shipped with params" do
      expect(BoxShippedQuery.call(start_date: date, end_date: date)).to be(0)
    end

    it "#purchases_total with no params" do
      expect(PurchasesTotalQuery.call).to eq({})
    end

    it "#purchases_total with params" do
      expect(PurchasesTotalQuery.call(start_date: date, end_date: date)).to eq({})
    end

    it "#inventory_per_location with no params" do
      expect(InventoryPerLocationQuery.call).to eq({})
    end

    it "#inventory_per_location with params" do
      expect(InventoryPerLocationQuery.call(start_date: date, end_date: date)).to eq({})
    end

    it "#total_items with no params" do
      expect(TotalItemsQuery.call).to eq({})
    end

    it "#total_items with params" do
      expect(TotalItemsQuery.call(start_date: date, end_date: date)).to eq({})
    end
  end
end
