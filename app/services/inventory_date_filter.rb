class InventoryDateFilter
  INITIAL_FILTERS = {}

  attr_reader :params

  def self.call(params = INITIAL_FILTERS)
    new(params).call
  end

  def initialize(params = INITIAL_FILTERS)
    @params = params
  end

  def set_value_for_inventory(hash)
    inventory_params.each do |key, value|
      hash[key.to_sym] = value if value.present?
    end
  end

  def call
    INITIAL_FILTERS.tap do |hash|
      set_value_for_inventory(hash) if inventory_params.present?
    end
  end

  private

  def inventory_params
    params[:inventory]
  end

end
