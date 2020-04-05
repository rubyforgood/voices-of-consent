class PurchasesTotalQuery < BaseTimeFilteredQuery
  def function
    :count
  end

  def search_field
    :created_at
  end

  def relation
    Purchase.joins("INNER JOIN boxes on boxes.shipping_payment_id = purchases.id").group("boxes.shipping_payment_id")
  end
end
