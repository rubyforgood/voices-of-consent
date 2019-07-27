require 'rails_helper'

RSpec.describe "attendances/edit", type: :view do
  before(:each) do
    @attendance = assign(:attendance, Attendance.create!(
      :meeting => nil,
      :user => nil,
      :special_duties => "MyString",
      :completed_hours => false
    ))
  end

  it "renders the edit attendance form" do
    render

    assert_select "form[action=?][method=?]", attendance_path(@attendance), "post" do

      assert_select "input[name=?]", "attendance[meeting_id]"

      assert_select "input[name=?]", "attendance[user_id]"

      assert_select "input[name=?]", "attendance[special_duties]"

      assert_select "input[name=?]", "attendance[completed_hours]"
    end
  end
end
