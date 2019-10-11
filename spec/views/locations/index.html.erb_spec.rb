require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    @locations = create_list(:location, 2, name: "Name")
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
