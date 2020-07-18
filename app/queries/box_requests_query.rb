class BoxRequestsQuery < BaseTimeFilteredQuery
  def function
    :count
  end

  def search_field
    :created_at
  end

  def relation
    BoxRequest.all
  end
end
