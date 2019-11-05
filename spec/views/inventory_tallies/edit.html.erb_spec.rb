require 'rails_helper'

RSpec.describe "inventory_tallies/edit", type: :view do
  before(:each) do
    @inventory_tally = create(:inventory_tally)
  end

  it "renders the edit inventory_tally form" do
    render

    assert_select "form[action=?][method=?]", inventory_tally_path(@inventory_tally), "post" do

      assert_select "textarea[name=?]", "inventory_tally[additional_location_info]"

      assert_select "select[name=?]", "inventory_tally[inventory_type_id]"

      assert_select "select[name=?]", "inventory_tally[storage_location_id]"
    end
  end
end
