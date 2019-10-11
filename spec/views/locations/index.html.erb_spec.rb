require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    assign(:locations, [
      Location.create!(
        :name => "Name",
        :street_address => "Street Address",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :location_type => 2
      ),
      Location.create!(
        :name => "Name",
        :street_address => "Street Address",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :location_type => 2
      )
    ])
  end

  it "renders a list of locations" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Street Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => 'Type'.to_s, :count => 2
  end
end
