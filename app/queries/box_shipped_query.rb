class BoxShippedQuery < BaseTimeFilteredQuery
  def function
    :count
  end

  def search_field
    :created_at
  end

  def relation
    Box.includes(:shipped_by)
  end
end
