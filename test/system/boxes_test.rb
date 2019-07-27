require "application_system_test_case"

class BoxesTest < ApplicationSystemTestCase
  setup do
    @box = boxes(:one)
  end

  test "visiting the index" do
    visit boxes_url
    assert_selector "h1", text: "Boxes"
  end

  test "creating a Box" do
    visit boxes_url
    click_on "New Box"

    fill_in "Assembled by", with: @box.assembled_by_id
    fill_in "Box request", with: @box.box_request_id
    fill_in "Design reviewed by", with: @box.design_reviewed_by_id
    fill_in "Designed by", with: @box.designed_by_id
    fill_in "Shipment tracking number", with: @box.shipment_tracking_number
    fill_in "Shipped at", with: @box.shipped_at
    fill_in "Shipped by", with: @box.shipped_by_id
    fill_in "Shipping payment", with: @box.shipping_payment_id
    click_on "Create Box"

    assert_text "Box was successfully created"
    click_on "Back"
  end

  test "updating a Box" do
    visit boxes_url
    click_on "Edit", match: :first

    fill_in "Assembled by", with: @box.assembled_by_id
    fill_in "Box request", with: @box.box_request_id
    fill_in "Design reviewed by", with: @box.design_reviewed_by_id
    fill_in "Designed by", with: @box.designed_by_id
    fill_in "Shipment tracking number", with: @box.shipment_tracking_number
    fill_in "Shipped at", with: @box.shipped_at
    fill_in "Shipped by", with: @box.shipped_by_id
    fill_in "Shipping payment", with: @box.shipping_payment_id
    click_on "Update Box"

    assert_text "Box was successfully updated"
    click_on "Back"
  end

  test "destroying a Box" do
    visit boxes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Box was successfully destroyed"
  end
end
