require 'rails_helper'

RSpec.describe "attendances/show", type: :view do
  before(:each) do

    @attendance = create(:attendance)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Special Duties/)
    expect(rendered).to match(/false/)
  end
end
