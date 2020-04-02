# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'box_requests/edit', type: :view do
  before(:each) do
    @requester = assign(:requester, Requester.new)
    @box_request = assign(:box_request, @requester.box_requests.new)
  end

  it 'renders the edit box_request form' do
    render

    assert_select 'form[action=?][method=?]', box_requests_path(@box_request), 'post' do
      assert_select 'textarea[name=?]', 'box_request[tag_list]'

      assert_select 'textarea[name=?]', 'box_request[summary]'

      assert_select 'input[value=?]', 'Complete Box Review'
    end
  end
end
