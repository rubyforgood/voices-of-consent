require 'test_helper'

class InventoryTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventory_type = inventory_types(:one)
  end

  test "should get index" do
    get inventory_types_url
    assert_response :success
  end

  test "should get new" do
    get new_inventory_type_url
    assert_response :success
  end

  test "should create inventory_type" do
    assert_difference('InventoryType.count') do
      post inventory_types_url, params: { inventory_type: {  } }
    end

    assert_redirected_to inventory_type_url(InventoryType.last)
  end

  test "should show inventory_type" do
    get inventory_type_url(@inventory_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_inventory_type_url(@inventory_type)
    assert_response :success
  end

  test "should update inventory_type" do
    patch inventory_type_url(@inventory_type), params: { inventory_type: {  } }
    assert_redirected_to inventory_type_url(@inventory_type)
  end

  test "should destroy inventory_type" do
    assert_difference('InventoryType.count', -1) do
      delete inventory_type_url(@inventory_type)
    end

    assert_redirected_to inventory_types_url
  end
end
