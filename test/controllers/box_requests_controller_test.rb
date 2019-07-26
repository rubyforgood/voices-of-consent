require 'test_helper'

class BoxRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @box_request = box_requests(:one)
  end

  test "should get index" do
    get box_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_box_request_url
    assert_response :success
  end

  test "should create box_request" do
    assert_difference('BoxRequest.count') do
      post box_requests_url, params: { box_request: { question_re_affect: @box_request.question_re_affect, question_re_current_situation: @box_request.question_re_current_situation, question_re_if_not_self_completed: @box_request.question_re_if_not_self_completed, question_re_referral_source: @box_request.question_re_referral_source, summary: @box_request.summary } }
    end

    assert_redirected_to box_request_url(BoxRequest.last)
  end

  test "should show box_request" do
    get box_request_url(@box_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_box_request_url(@box_request)
    assert_response :success
  end

  test "should update box_request" do
    patch box_request_url(@box_request), params: { box_request: { question_re_affect: @box_request.question_re_affect, question_re_current_situation: @box_request.question_re_current_situation, question_re_if_not_self_completed: @box_request.question_re_if_not_self_completed, question_re_referral_source: @box_request.question_re_referral_source, summary: @box_request.summary } }
    assert_redirected_to box_request_url(@box_request)
  end

  test "should destroy box_request" do
    assert_difference('BoxRequest.count', -1) do
      delete box_request_url(@box_request)
    end

    assert_redirected_to box_requests_url
  end
end
