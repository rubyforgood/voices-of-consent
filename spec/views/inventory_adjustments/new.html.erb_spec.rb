require 'rails_helper'

RSpec.describe "inventory_adjustments/new", type: :view do
  before(:each) do
    assign(:inventory_adjustment, InventoryAdjustment.new())
  end

  it "renders new inventory_adjustment form" do
    render

    assert_select "form[action=?][method=?]", inventory_adjustments_path, "post" do
    end
  end
end
