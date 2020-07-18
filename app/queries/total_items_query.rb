class TotalItemsQuery < BaseTimeFilteredQuery
  def function
    :count
  end

  def search_field
    :created_at
  end

  def relation
    BoxItem.joins(:inventory_type).group("inventory_types.name")
  end
end
