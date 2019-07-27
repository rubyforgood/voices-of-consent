require 'rails_helper'

RSpec.describe "inventory_adjustments/show", type: :view do
  before(:each) do
    @inventory_adjustment = assign(:inventory_adjustment, InventoryAdjustment.create!(
      :inventory_tally => nil,
      :purchase => nil,
      :box_item => nil,
      :total_cost => 2,
      :tally_quantity_start => 3,
      :tally_quantity_end => 4,
      :adjustment_quantity => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
