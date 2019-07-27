require 'rails_helper'

RSpec.describe "inventory_adjustments/edit", type: :view do
  before(:each) do
    @inventory_adjustment = assign(:inventory_adjustment, InventoryAdjustment.create!())
  end

  it "renders the edit inventory_adjustment form" do
    render

    assert_select "form[action=?][method=?]", inventory_adjustment_path(@inventory_adjustment), "post" do
    end
  end
end
