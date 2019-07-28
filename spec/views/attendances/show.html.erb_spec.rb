require 'rails_helper'

RSpec.describe "attendances/show", type: :view do
  before(:each) do
    @attendance = assign(:attendance, Attendance.create!(
      :meeting => nil,
      :user => nil,
      :special_duties => "Special Duties",
      :completed_hours => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Special Duties/)
    expect(rendered).to match(/false/)
  end
end
