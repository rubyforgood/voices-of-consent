# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'inventory_types/show', type: :view do
  before(:each) do
    @inventory_type = create(:inventory_type, name: 'Name', description: 'Description')
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
  end
end
