require 'rails_helper'

feature 'Index Dashboard', type: :feature do
  before do
    login
  end

  it 'shows dashboard', js: true do
    visit root_path

    expect(page).to have_content 'Dashboard'
    expect(page).to have_content 'Box Shipped'
    expect(page).to have_content 'Box Requests'
    expect(page).to have_content 'Total Items grouped by inventory'
    expect(page).to have_content 'Inventory type per location'
    expect(page).to have_content 'Total Purchases that have a box via shipping payment'
    expect(page).to have_content 0
    click_button 'Filter'
  end
end
