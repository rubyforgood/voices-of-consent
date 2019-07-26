require 'test_helper'

class RequestersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @requester = requesters(:one)
  end

  test "should get index" do
    get requesters_url
    assert_response :success
  end

  test "should get new" do
    get new_requester_url
    assert_response :success
  end

  test "should create requester" do
    assert_difference('Requester.count') do
      post requesters_url, params: { requester: { city: @requester.city, county: @requester.county, first_name: @requester.first_name, last_name: @requester.last_name, email: @requester.email, ok_to_call: @requester.ok_to_call, ok_to_email: @requester.ok_to_email, ok_to_mail: @requester.ok_to_mail, ok_to_text: @requester.ok_to_text, phone: @requester.phone, state: @requester.state, street_address: @requester.street_address, underage: @requester.underage, zip: @requester.zip } }
    end

    assert_redirected_to requester_url(Requester.last)
  end

  test "should show requester" do
    get requester_url(@requester)
    assert_response :success
  end

  test "should get edit" do
    get edit_requester_url(@requester)
    assert_response :success
  end

  test "should update requester" do
    patch requester_url(@requester), params: { requester: { city: @requester.city, county: @requester.county, first_name: @requester.first_name, last_name: @requester.last_name, email: @requester.email, ok_to_call: @requester.ok_to_call, ok_to_email: @requester.ok_to_email, ok_to_mail: @requester.ok_to_mail, ok_to_text: @requester.ok_to_text, phone: @requester.phone, state: @requester.state, street_address: @requester.street_address, underage: @requester.underage, zip: @requester.zip } }
    assert_redirected_to requester_url(@requester)
  end

  test "should destroy requester" do
    assert_difference('Requester.count', -1) do
      delete requester_url(@requester)
    end

    assert_redirected_to requesters_url
  end
end
