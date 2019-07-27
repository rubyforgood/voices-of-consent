require 'rails_helper'

RSpec.describe "purchases/new", type: :view do
  before(:each) do
    assign(:purchase, Purchase.new(
      :location => nil,
      :total_price => 1.5,
      :purchased_by => nil,
      :reimbursed_by => nil,
      :reimbursement_check_number => "MyString",
      :reimbursement_status => "MyString"
    ))
  end

  it "renders new purchase form" do
    render

    assert_select "form[action=?][method=?]", purchases_path, "post" do

      assert_select "input[name=?]", "purchase[location_id]"

      assert_select "input[name=?]", "purchase[total_price]"

      assert_select "input[name=?]", "purchase[purchased_by_id]"

      assert_select "input[name=?]", "purchase[reimbursed_by_id]"

      assert_select "input[name=?]", "purchase[reimbursement_check_number]"

      assert_select "input[name=?]", "purchase[reimbursement_status]"
    end
  end
end
