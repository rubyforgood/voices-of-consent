require 'rails_helper'

RSpec.describe "box_request_abuse_types/index", type: :view do
  before(:each) do
    @box_request_abuse_types = create_list(:box_request_abuse_type, 2)
  end

  it "renders a list of box_request_abuse_types" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
