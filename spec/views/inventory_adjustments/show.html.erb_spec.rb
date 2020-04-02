# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'inventory_adjustments/show', type: :view do
  before(:each) do
    @inventory_adjustment = create(:inventory_adjustment, total_cost: 2, adjustment_quantity: 5)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/5/)
  end
end
