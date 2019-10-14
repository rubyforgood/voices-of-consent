require 'rails_helper'

RSpec.describe "attendances/index", type: :view do
  before(:each) do
    @attendances = build_stubbed_list(:attendance, 2)
  end

  it "renders a list of attendances" do
    puts(render)
    assert_select "tr>td>a[href='/attendances/#{@attendances[0].id}']", :text => 'Show', :count => 1
    assert_select "tr>td>a[href='/attendances/#{@attendances[1].id}']", :text => 'Show', :count => 1
  end
end
