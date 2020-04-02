# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'inventory_adjustments/index', type: :view do
  before(:each) { @inventory_adjustments = build_stubbed_list(:inventory_adjustment, 2) }

  it 'renders a list of inventory_adjustments' do
    render
    assert_select "tr>td>a[href='/inventory_adjustments/#{@inventory_adjustments[0].id}']",
                  text: 'Show', count: 1
    assert_select "tr>td>a[href='/inventory_adjustments/#{@inventory_adjustments[1].id}']",
                  text: 'Show', count: 1
  end
end
