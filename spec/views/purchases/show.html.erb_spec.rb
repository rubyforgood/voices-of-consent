require 'rails_helper'

RSpec.describe "purchases/show", type: :view do
  before(:each) do
    @purchase = assign(:purchase, Purchase.create!(
      :location => nil,
      :total_price => 2.5,
      :purchased_by => nil,
      :reimbursed_by => nil,
      :reimbursement_check_number => "Reimbursement Check Number",
      :reimbursement_status => "Reimbursement Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Reimbursement Check Number/)
    expect(rendered).to match(/Reimbursement Status/)
  end
end
