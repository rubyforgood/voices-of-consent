# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'purchases/edit', type: :view do
  before(:each) { @purchase = create(:purchase) }

  it 'renders the edit purchase form' do
    render

    assert_select 'form[action=?][method=?]', purchase_path(@purchase), 'post' do
      assert_select 'select[name=?]', 'purchase[location_id]'
      assert_select 'input[name=?]', 'purchase[total_price]'
      assert_select 'select[name=?]', 'purchase[purchased_by_id]'
      assert_select 'select[name=?]', 'purchase[reimbursed_by_id]'
      assert_select 'input[name=?]', 'purchase[reimbursement_check_number]'
      assert_select 'input[name=?]', 'purchase[reimbursement_status]'
    end
  end
end
