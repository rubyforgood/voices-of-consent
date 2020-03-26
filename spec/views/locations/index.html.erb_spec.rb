# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'locations/index', type: :view do
  before(:each) { @locations = build_stubbed_list(:location, 2) }

  it 'renders a list of locations' do
    render

    assert_select 'td', text: @locations[0].location_type, count: 2

    assert_select 'td', text: @locations[0].name, count: 1
    assert_select 'td', text: @locations[0].street_address, count: 1
    assert_select 'td', text: @locations[0].city, count: 1
    assert_select 'td', text: @locations[0].state, count: 1
    assert_select 'td', text: @locations[0].zip, count: 1

    assert_select 'td', text: @locations[1].name, count: 1
    assert_select 'td', text: @locations[1].street_address, count: 1
    assert_select 'td', text: @locations[1].city, count: 1
    assert_select 'td', text: @locations[1].state, count: 1
    assert_select 'td', text: @locations[1].zip, count: 1
  end
end
