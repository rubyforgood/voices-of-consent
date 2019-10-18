require 'rails_helper'

RSpec.describe "meeting_types/index", type: :view do
  before(:each) do
    @meeting_types = build_stubbed_list(:meeting_type, 2)
  end

  it "renders a list of meeting_types" do
    render
    assert_select "tr>td>a[href='/meeting_types/#{@meeting_types[0].id}']", :text => "Show", :count => 1
    assert_select "tr>td>a[href='/meeting_types/#{@meeting_types[1].id}']", :text => "Show", :count => 1
  end
end
