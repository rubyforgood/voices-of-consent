require "application_system_test_case"

class BoxRequestsTest < ApplicationSystemTestCase
  setup do
    @box_request = box_requests(:one)
  end

  test "visiting the index" do
    visit box_requests_url
    assert_selector "h1", text: "Box Requests"
  end

  test "creating a Box request" do
    visit box_requests_url
    click_on "New Box Request"

    fill_in "Question re affect", with: @box_request.question_re_affect
    fill_in "Question re current situation", with: @box_request.question_re_current_situation
    fill_in "Question re if not self completed", with: @box_request.question_re_if_not_self_completed
    fill_in "Question re referral source", with: @box_request.question_re_referral_source
    fill_in "Summary", with: @box_request.summary
    click_on "Create Box request"

    assert_text "Box request was successfully created"
    click_on "Back"
  end

  test "updating a Box request" do
    visit box_requests_url
    click_on "Edit", match: :first

    fill_in "Question re affect", with: @box_request.question_re_affect
    fill_in "Question re current situation", with: @box_request.question_re_current_situation
    fill_in "Question re if not self completed", with: @box_request.question_re_if_not_self_completed
    fill_in "Question re referral source", with: @box_request.question_re_referral_source
    fill_in "Summary", with: @box_request.summary
    click_on "Update Box request"

    assert_text "Box request was successfully updated"
    click_on "Back"
  end

  test "destroying a Box request" do
    visit box_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Box request was successfully destroyed"
  end
end
