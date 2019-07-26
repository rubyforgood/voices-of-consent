require "application_system_test_case"

class InventoryTalliesTest < ApplicationSystemTestCase
  setup do
    @inventory_tally = inventory_tallies(:one)
  end

  test "visiting the index" do
    visit inventory_tallies_url
    assert_selector "h1", text: "Inventory Tallies"
  end

  test "creating a Inventory tally" do
    visit inventory_tallies_url
    click_on "New Inventory Tally"

    click_on "Create Inventory tally"

    assert_text "Inventory tally was successfully created"
    click_on "Back"
  end

  test "updating a Inventory tally" do
    visit inventory_tallies_url
    click_on "Edit", match: :first

    click_on "Update Inventory tally"

    assert_text "Inventory tally was successfully updated"
    click_on "Back"
  end

  test "destroying a Inventory tally" do
    visit inventory_tallies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inventory tally was successfully destroyed"
  end
end
