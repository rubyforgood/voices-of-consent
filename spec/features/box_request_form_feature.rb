# frozen_string_literal: true

require 'rails_helper'

feature 'Box Request Form', type: :feature do
  let!(:abuse_type) { FactoryBot.create(:abuse_type) }

  before { login }

  it 'shows all abuse types', js: true do
    visit requesters_new_path

    expect(page).to have_content(abuse_type.name)
    expect(page).to have_content('All of the Above')
  end
end
