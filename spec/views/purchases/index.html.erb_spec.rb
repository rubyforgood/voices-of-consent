require 'rails_helper'

RSpec.describe "purchases/index", type: :view do
  before(:each) do
    assign(:purchases, [
      Purchase.create!(
        :location => nil,
        :total_price => 2.5,
        :purchased_by => nil,
        :reimbursed_by => nil,
        :reimbursement_check_number => "Reimbursement Check Number",
        :reimbursement_status => "Reimbursement Status"
      ),
      Purchase.create!(
        :location => nil,
        :total_price => 2.5,
        :purchased_by => nil,
        :reimbursed_by => nil,
        :reimbursement_check_number => "Reimbursement Check Number",
        :reimbursement_status => "Reimbursement Status"
      )
    ])
  end

  it "renders a list of purchases" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Reimbursement Check Number".to_s, :count => 2
    assert_select "tr>td", :text => "Reimbursement Status".to_s, :count => 2
  end
end
