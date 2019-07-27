require 'rails_helper'

RSpec.describe "inventory_adjustments/show", type: :view do
  before(:each) do
    @inventory_adjustment = assign(:inventory_adjustment, InventoryAdjustment.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
