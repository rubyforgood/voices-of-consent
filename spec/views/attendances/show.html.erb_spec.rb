# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'attendances/show', type: :view do
  before(:each) { @attendance = create(:attendance) }

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Special duties/)
    expect(rendered).to match(/Completed hours/)
  end
end
