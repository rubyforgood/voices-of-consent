require 'rails_helper'

RSpec.describe "inventory_tallies/index", type: :view do
  before(:each) do
    assign(:inventory_tallies, [
      InventoryTally.create!(
        :additional_location_info => "Additional Location Info",
        :cached_quantity => 2,
        :inventory_type => nil,
        :storage_location => nil
      ),
      InventoryTally.create!(
        :additional_location_info => "Additional Location Info",
        :cached_quantity => 2,
        :inventory_type => nil,
        :storage_location => nil
      )
    ])
  end

  it "renders a list of inventory_tallies" do
    render
    assert_select "tr>td", :text => "Additional Location Info".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
