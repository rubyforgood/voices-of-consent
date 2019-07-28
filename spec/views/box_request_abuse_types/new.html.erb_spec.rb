require 'rails_helper'

RSpec.describe "box_request_abuse_types/new", type: :view do
  before(:each) do
    assign(:box_request_abuse_type, BoxRequestAbuseType.new(
      :box_request => nil,
      :abuse_type => nil
    ))
  end

  it "renders new box_request_abuse_type form" do
    render

    assert_select "form[action=?][method=?]", box_request_abuse_types_path, "post" do

      assert_select "input[name=?]", "box_request_abuse_type[box_request_id]"

      assert_select "input[name=?]", "box_request_abuse_type[abuse_type_id]"
    end
  end
end
