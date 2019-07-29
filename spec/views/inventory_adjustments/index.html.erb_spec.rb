require 'rails_helper'

RSpec.describe "inventory_adjustments/index", type: :view do
  before(:each) do
    assign(:inventory_adjustments, [
      InventoryAdjustment.create!(
        :inventory_tally => nil,
        :purchase => nil,
        :box_item => nil,
        :total_cost => 2,
        :tally_quantity_start => 3,
        :tally_quantity_end => 4,
        :adjustment_quantity => 5
      ),
      InventoryAdjustment.create!(
        :inventory_tally => nil,
        :purchase => nil,
        :box_item => nil,
        :total_cost => 2,
        :tally_quantity_start => 3,
        :tally_quantity_end => 4,
        :adjustment_quantity => 5
      )
    ])
  end

  it "renders a list of inventory_adjustments" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
