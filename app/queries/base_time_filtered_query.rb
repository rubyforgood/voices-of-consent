class BaseTimeFilteredQuery
  def self.call(start_date: Date.current, end_date: Date.current)
    new.call(start_date: start_date, end_date: end_date)
  end

  def call(start_date: Date.current, end_date: Date.current)
    relation.where(search_field => start_date..end_date).public_send(function)
  end

  def function
    raise NotImplementedError
  end

  def search_field
    raise NotImplementedError
  end

  def relation
    raise NotImplementedError
  end
end
