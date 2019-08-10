require 'rails_helper'

RSpec.describe "inventory_types/new", type: :view do
  before(:each) do
    create(:inventory_type)
  end

  it "renders new inventory_type form" do
    render

    assert_select "form[action=?][method=?]", inventory_types_path, "post" do

      assert_select "input[name=?]", "inventory_type[name]"

      assert_select "input[name=?]", "inventory_type[description]"
    end
  end
end
