require 'rails_helper'

RSpec.describe "box_request_abuse_types/show", type: :view do
  before(:each) do
    @box_request_abuse_type = create(:box_request_abuse_type)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
