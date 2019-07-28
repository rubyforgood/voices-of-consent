require 'rails_helper'

RSpec.describe "inventory_adjustments/edit", type: :view do
  before(:each) do
    @inventory_adjustment = assign(:inventory_adjustment, InventoryAdjustment.create!(
      :inventory_tally => nil,
      :purchase => nil,
      :box_item => nil,
      :total_cost => 1,
      :tally_quantity_start => 1,
      :tally_quantity_end => 1,
      :adjustment_quantity => 1
    ))
  end

  it "renders the edit inventory_adjustment form" do
    render

    assert_select "form[action=?][method=?]", inventory_adjustment_path(@inventory_adjustment), "post" do

      assert_select "input[name=?]", "inventory_adjustment[inventory_tally_id]"

      assert_select "input[name=?]", "inventory_adjustment[purchase_id]"

      assert_select "input[name=?]", "inventory_adjustment[box_item_id]"

      assert_select "input[name=?]", "inventory_adjustment[total_cost]"

      assert_select "input[name=?]", "inventory_adjustment[tally_quantity_start]"

      assert_select "input[name=?]", "inventory_adjustment[tally_quantity_end]"

      assert_select "input[name=?]", "inventory_adjustment[adjustment_quantity]"
    end
  end
end
