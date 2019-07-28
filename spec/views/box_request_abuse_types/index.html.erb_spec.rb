require 'rails_helper'

RSpec.describe "box_request_abuse_types/index", type: :view do
  before(:each) do
    assign(:box_request_abuse_types, [
      BoxRequestAbuseType.create!(
        :box_request => nil,
        :abuse_type => nil
      ),
      BoxRequestAbuseType.create!(
        :box_request => nil,
        :abuse_type => nil
      )
    ])
  end

  it "renders a list of box_request_abuse_types" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
