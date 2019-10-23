require 'rails_helper'

RSpec.describe "box_requests/new", type: :view do
  before(:each) do
    @box_request = assign(:box_request, BoxRequest.new)
  end

  it "renders the edit box_request form" do
    render

    assert_select "form[action=?][method=?]", box_requests_path, "post" do

      assert_select "textarea[name=?]", "box_request[tag_list]"

      assert_select "textarea[name=?]", "box_request[summary]"

      assert_select "input[value=?]", "Complete Box Review"
    end
  end
end
