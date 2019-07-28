require 'rails_helper'

RSpec.describe "inventory_tallies/edit", type: :view do
  before(:each) do
    @inventory_tally = assign(:inventory_tally, InventoryTally.create!(
      :additional_location_info => "MyString",
      :cached_quantity => 1,
      :inventory_type => nil,
      :storage_location => nil
    ))
  end

  it "renders the edit inventory_tally form" do
    render

    assert_select "form[action=?][method=?]", inventory_tally_path(@inventory_tally), "post" do

      assert_select "input[name=?]", "inventory_tally[additional_location_info]"

      assert_select "input[name=?]", "inventory_tally[cached_quantity]"

      assert_select "input[name=?]", "inventory_tally[inventory_type_id]"

      assert_select "input[name=?]", "inventory_tally[storage_location_id]"
    end
  end
end
