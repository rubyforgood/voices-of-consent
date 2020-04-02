# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'inventory_types/edit', type: :view do
  before(:each) { @inventory_type = create(:inventory_type) }

  it 'renders the edit inventory_type form' do
    render

    assert_select 'form[action=?][method=?]', inventory_type_path(@inventory_type), 'post' do
      assert_select 'input[name=?]', 'inventory_type[name]'

      assert_select 'input[name=?]', 'inventory_type[description]'
    end
  end
end
