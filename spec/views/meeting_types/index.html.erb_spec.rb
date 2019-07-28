require 'rails_helper'

RSpec.describe "meeting_types/index", type: :view do
  before(:each) do
    assign(:meeting_types, [
      MeetingType.create!(
        :name => "Name",
        :description => "MyText"
      ),
      MeetingType.create!(
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of meeting_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
