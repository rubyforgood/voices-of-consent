require 'rails_helper'

RSpec.describe "locations/show", type: :view do
  before(:each) do
    @location = create(:location,
      :name => "Name",
      :street_address => "Street Address",
      :city => "City",
      :state => "State",
      :zip => "Zip",
      :location_type => 2
    )
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Street Address/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Zip/)
    expect(rendered).to match(/2/)
  end
end
