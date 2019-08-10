require 'rails_helper'

RSpec.describe "purchases/index", type: :view do
  before(:each) do
    @purchases = create_list(:purchase, 2)
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
