require 'rails_helper'

RSpec.describe "box_request_abuse_types/index", type: :view do
  before(:each) do
    @box_request_abuse_types = build_stubbed_list(:box_request_abuse_type, 2)
  end

  it "renders a list of box_request_abuse_types" do
    render
    assert_select "tbody>tr", :count => 2
    assert_select "tbody>tr>td>a[href='/box_request_abuse_types/#{@box_request_abuse_types[0].id}']",
                  :text => 'Show', :count => 1
    assert_select "tbody>tr>td>a[href='/box_request_abuse_types/#{@box_request_abuse_types[1].id}']",
                  :text => 'Show', :count => 1
  end
end
