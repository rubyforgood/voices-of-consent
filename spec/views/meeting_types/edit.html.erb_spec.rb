require 'rails_helper'

RSpec.describe "meeting_types/edit", type: :view do
  before(:each) do
    @meeting_type = create(:meeting_type)
  end

  it "renders the edit meeting_type form" do
    render

    assert_select "form[action=?][method=?]", meeting_type_path(@meeting_type), "post" do

      assert_select "input[name=?]", "meeting_type[name]"

      assert_select "textarea[name=?]", "meeting_type[description]"
    end
  end
end
