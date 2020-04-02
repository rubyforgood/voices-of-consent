# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'locations/edit', type: :view do
  before(:each) { @location = create(:location) }

  it 'renders the edit location form' do
    render

    assert_select 'form[action=?][method=?]', location_path(@location), 'post' do
      assert_select 'input[name=?]', 'location[name]'

      assert_select 'input[name=?]', 'location[street_address]'

      assert_select 'input[name=?]', 'location[city]'

      assert_select 'input[name=?]', 'location[state]'

      assert_select 'input[name=?]', 'location[zip]'

      assert_select 'select[name=?]', 'location[location_type]'
    end
  end
end
