# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'attendances/new', type: :view do
  before(:each) { @attendance = create(:attendance) }

  it 'renders new attendance form' do
    render

    assert_select 'form[action=?][method=?]',
                  attendance_path(@attendance),
                  'post' do
      assert_select 'select[name=?]', 'attendance[meeting_id]'

      assert_select 'select[name=?]', 'attendance[user_id]'

      assert_select 'input[name=?]', 'attendance[special_duties]'

      assert_select 'input[name=?]', 'attendance[completed_hours]'
    end
  end
end
