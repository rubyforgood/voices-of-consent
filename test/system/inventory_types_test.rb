require "application_system_test_case"

class InventoryTypesTest < ApplicationSystemTestCase
  setup do
    @inventory_type = inventory_types(:one)
  end

  test "visiting the index" do
    visit inventory_types_url
    assert_selector "h1", text: "Inventory Types"
  end

  test "creating a Inventory type" do
    visit inventory_types_url
    click_on "New Inventory Type"

    click_on "Create Inventory type"

    assert_text "Inventory type was successfully created"
    click_on "Back"
  end

  test "updating a Inventory type" do
    visit inventory_types_url
    click_on "Edit", match: :first

    click_on "Update Inventory type"

    assert_text "Inventory type was successfully updated"
    click_on "Back"
  end

  test "destroying a Inventory type" do
    visit inventory_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inventory type was successfully destroyed"
  end
end
