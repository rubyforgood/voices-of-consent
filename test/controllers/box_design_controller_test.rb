require 'test_helper'

class BoxDesignControllerTest < ActionDispatch::IntegrationTest
  test "should get claim" do
    get box_design_claim_url
    assert_response :success
  end

  test "should get design" do
    get box_design_design_url
    assert_response :success
  end

end
