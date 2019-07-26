require 'test_helper'

class InventoryTalliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventory_tally = inventory_tallies(:one)
  end

  test "should get index" do
    get inventory_tallies_url
    assert_response :success
  end

  test "should get new" do
    get new_inventory_tally_url
    assert_response :success
  end

  test "should create inventory_tally" do
    assert_difference('InventoryTally.count') do
      post inventory_tallies_url, params: { inventory_tally: {  } }
    end

    assert_redirected_to inventory_tally_url(InventoryTally.last)
  end

  test "should show inventory_tally" do
    get inventory_tally_url(@inventory_tally)
    assert_response :success
  end

  test "should get edit" do
    get edit_inventory_tally_url(@inventory_tally)
    assert_response :success
  end

  test "should update inventory_tally" do
    patch inventory_tally_url(@inventory_tally), params: { inventory_tally: {  } }
    assert_redirected_to inventory_tally_url(@inventory_tally)
  end

  test "should destroy inventory_tally" do
    assert_difference('InventoryTally.count', -1) do
      delete inventory_tally_url(@inventory_tally)
    end

    assert_redirected_to inventory_tallies_url
  end
end
