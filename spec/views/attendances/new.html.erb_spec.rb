require 'rails_helper'

RSpec.describe "attendances/new", type: :view do
  before(:each) do
    assign(:attendance, Attendance.new(
      :meeting => nil,
      :user => nil,
      :special_duties => "MyString",
      :completed_hours => false
    ))
  end

  it "renders new attendance form" do
    render

    assert_select "form[action=?][method=?]", attendances_path, "post" do

      assert_select "input[name=?]", "attendance[meeting_id]"

      assert_select "input[name=?]", "attendance[user_id]"

      assert_select "input[name=?]", "attendance[special_duties]"

      assert_select "input[name=?]", "attendance[completed_hours]"
    end
  end
end
