class BoxRequestsQuery
  def self.call(start_date: Date.current, end_date: Date.current)
    BoxRequest.where(created_at: start_date.to_date..end_date.to_date).count
  end
end
