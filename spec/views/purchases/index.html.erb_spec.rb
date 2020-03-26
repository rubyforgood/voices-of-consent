# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'purchases/index', type: :view do
  before(:each) do
    @purchases = [
      create(
        :purchase,
        location: create(:location, name: 'MyGreatLocation'),
        total_price: 1.5,
        purchased_by:
          create(
            :user,
            volunteer:
              create(:volunteer, first_name: 'MyGreat', last_name: 'Name')
          ),
        reimbursement_check_number: 'GreatReimbursementCheckNumber',
        reimbursement_status: 'GreatReimbursementStatus'
      ),
      create(
        :purchase,
        location: create(:location, name: 'MyTerribleLocation'),
        total_price: 2.5,
        purchased_by:
          create(
            :user,
            volunteer:
              create(:volunteer, first_name: 'MyTerrible', last_name: 'Name')
          ),
        reimbursement_check_number: 'TerribleReimbursementCheckNumber',
        reimbursement_status: 'TerribleReimbursementStatus'
      )
    ]
  end

  it 'renders a list of purchases' do
    render
    assert_select 'tr>td', text: 'MyGreatLocation', count: 1
    assert_select 'tr>td', text: 1.5.to_s, count: 1
    assert_select 'tr>td', text: 'MyGreat Name', count: 1
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 'GreatReimbursementCheckNumber', count: 1
    assert_select 'tr>td', text: 'GreatReimbursementStatus'.to_s, count: 1
    assert_select 'tr>td', text: 'MyTerribleLocation', count: 1
    assert_select 'tr>td', text: 2.5.to_s, count: 1
    assert_select 'tr>td', text: 'MyTerrible Name', count: 1
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 'TerribleReimbursementCheckNumber', count: 1
    assert_select 'tr>td', text: 'TerribleReimbursementStatus'.to_s, count: 1
  end
end
