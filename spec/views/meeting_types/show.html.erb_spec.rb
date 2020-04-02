# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'meeting_types/show', type: :view do
  before(:each) do
    @meeting_type = assign(:meeting_type, MeetingType.create!(name: 'Name', description: 'MyText'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
