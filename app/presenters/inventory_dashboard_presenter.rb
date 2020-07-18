class InventoryDashboardPresenter
  attr_reader :start_date, :end_date

  def initialize(start_date: Date.current, end_date: Date.current)
    @start_date = start_date.to_date
    @end_date = end_date.to_date
  end

  def total_box_requests
    BoxRequestsQuery.call(start_date: start_date, end_date: end_date)
  end

  def total_box_shipped
    BoxShippedQuery.call(start_date: start_date, end_date: end_date)
  end

  def purchases_total
    PurchasesTotalQuery.call(start_date: start_date, end_date: end_date)
  end

  def inventory_per_location
    InventoryPerLocationQuery.call(start_date: start_date, end_date: end_date)
  end

  def total_items
    TotalItemsQuery.call(start_date: start_date, end_date: end_date)
  end
end
