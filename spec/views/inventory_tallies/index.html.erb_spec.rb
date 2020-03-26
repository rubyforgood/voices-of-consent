# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'inventory_tallies/index', type: :view do
  before(:each) do
    @inventory_tallies =
      build_stubbed_list(
        :inventory_tally,
        2,
        additional_location_info: 'Additional Location Info'
      )
  end

  it 'renders a list of inventory_tallies' do
    render
    assert_select 'tr>td', text: 'Additional Location Info', count: 2
    assert_select "tr>td>a[href='/inventory_tallies/#{
                    @inventory_tallies[0].id
                  }']",
                  text: 'Show', count: 1
    assert_select "tr>td>a[href='/inventory_tallies/#{
                    @inventory_tallies[1].id
                  }']",
                  text: 'Show', count: 1
  end
end
