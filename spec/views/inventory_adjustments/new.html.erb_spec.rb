require 'rails_helper'

RSpec.describe "inventory_adjustments/new", type: :view do
  before(:each) do
    @inventory_adjustment = create(:inventory_adjustment)
  end

  it "renders new inventory_adjustment form" do
    render

    assert_select "form[action=?][method=?]", inventory_adjustment_path(@inventory_adjustment), "post" do

      assert_select "select[name=?]", "inventory_adjustment[inventory_tally_id]"

      assert_select "select[name=?]", "inventory_adjustment[purchase_id]"

      assert_select "select[name=?]", "inventory_adjustment[box_item_id]"

      assert_select "input[name=?]", "inventory_adjustment[total_cost]"

      assert_select "input[name=?]", "inventory_adjustment[adjustment_quantity]"
    end
  end
end
