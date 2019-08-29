require 'rails_helper'

RSpec.describe "inventory_tallies/show", type: :view do
  before(:each) do
    @inventory_tally = create(:inventory_tally,
      :additional_location_info => "Additional Location Info",
      :cached_quantity => 2,
      :inventory_type => create(:inventory_type),
      :storage_location => create(:location)
    )
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Additional Location Info/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
