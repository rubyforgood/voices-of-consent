require 'rails_helper'

RSpec.describe "inventory_adjustments/index", type: :view do
  before(:each) do
    assign(:inventory_adjustments, [
      InventoryAdjustment.create!(),
      InventoryAdjustment.create!()
    ])
  end

  it "renders a list of inventory_adjustments" do
    render
  end
end
