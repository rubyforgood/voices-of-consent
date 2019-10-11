require 'rails_helper'

RSpec.describe "meeting_types/index", type: :view do
  before(:each) do
    @meeting_types = create_list(:meeting_type, 2)
  end

  it "renders a list of meeting_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
