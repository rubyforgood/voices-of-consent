require 'rails_helper'

RSpec.describe "inventory_tallies/show", type: :view do
  before(:each) do
    @inventory_tally = assign(:inventory_tally, InventoryTally.create!(
      :additional_location_info => "Additional Location Info",
      :inventory_type => nil,
      :storage_location => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Additional Location Info/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
