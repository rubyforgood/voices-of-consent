require 'rails_helper'

RSpec.describe "inventory_types/index", type: :view do
  before(:each) do
    assign(:inventory_types, [
      InventoryType.create!(
        :name => "Name",
        :description => "Description"
      ),
      InventoryType.create!(
        :name => "Name",
        :description => "Description"
      )
    ])
  end

  it "renders a list of inventory_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
