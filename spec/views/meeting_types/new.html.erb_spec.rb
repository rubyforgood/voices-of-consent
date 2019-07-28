require 'rails_helper'

RSpec.describe "meeting_types/new", type: :view do
  before(:each) do
    assign(:meeting_type, MeetingType.new(
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new meeting_type form" do
    render

    assert_select "form[action=?][method=?]", meeting_types_path, "post" do

      assert_select "input[name=?]", "meeting_type[name]"

      assert_select "textarea[name=?]", "meeting_type[description]"
    end
  end
end
