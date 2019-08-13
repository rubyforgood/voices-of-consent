require 'rails_helper'

RSpec.describe "inventory_tallies/new", type: :view do
  before(:each) do
    assign(:inventory_tally, InventoryTally.new(
      :additional_location_info => "MyString",
      :inventory_type => nil,
      :storage_location => nil
    ))
  end

  it "renders new inventory_tally form" do
    render

    assert_select "form[action=?][method=?]", inventory_tallies_path, "post" do

      assert_select "input[name=?]", "inventory_tally[additional_location_info]"

      assert_select "input[name=?]", "inventory_tally[inventory_type_id]"

      assert_select "input[name=?]", "inventory_tally[storage_location_id]"
    end
  end
end
