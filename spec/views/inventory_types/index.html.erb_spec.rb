require 'rails_helper'

RSpec.describe "inventory_types/index", type: :view do
  before(:each) do
    @inventory_types = build_stubbed_list(:inventory_type, 2)
  end

  it "renders a list of inventory_types" do
    render
    assert_select "tr>td>a[href='/inventory_types/#{@inventory_types[0].id}']", :text => "Show", :count => 1
    assert_select "tr>td>a[href='/inventory_types/#{@inventory_types[1].id}']", :text => "Show", :count => 1
  end
end
