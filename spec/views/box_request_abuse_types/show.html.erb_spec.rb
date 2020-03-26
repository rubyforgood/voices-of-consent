# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'box_request_abuse_types/show', type: :view do
  before(:each) { @box_request_abuse_type = create(:box_request_abuse_type) }

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
