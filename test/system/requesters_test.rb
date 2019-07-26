require "application_system_test_case"

class RequestersTest < ApplicationSystemTestCase
  setup do
    @requester = requesters(:one)
  end

  test "visiting the index" do
    visit requesters_url
    assert_selector "h1", text: "Requesters"
  end

  test "creating a Requester" do
    visit requesters_url
    click_on "New Requester"

    fill_in "City", with: @requester.city
    fill_in "County", with: @requester.county
    fill_in "First name", with: @requester.first_name
    fill_in "Last name", with: @requester.last_name
    fill_in "Ok to call", with: @requester.ok_to_call
    fill_in "Ok to email", with: @requester.ok_to_email
    fill_in "Ok to mail", with: @requester.ok_to_mail
    fill_in "Ok to text", with: @requester.ok_to_text
    fill_in "Phone", with: @requester.phone
    fill_in "State", with: @requester.state
    fill_in "Street address", with: @requester.street_address
    fill_in "Underage", with: @requester.underage
    fill_in "Zip", with: @requester.zip
    click_on "Create Requester"

    assert_text "Requester was successfully created"
    click_on "Back"
  end

  test "updating a Requester" do
    visit requesters_url
    click_on "Edit", match: :first

    fill_in "City", with: @requester.city
    fill_in "County", with: @requester.county
    fill_in "First name", with: @requester.first_name
    fill_in "Last name", with: @requester.last_name
    fill_in "Ok to call", with: @requester.ok_to_call
    fill_in "Ok to email", with: @requester.ok_to_email
    fill_in "Ok to mail", with: @requester.ok_to_mail
    fill_in "Ok to text", with: @requester.ok_to_text
    fill_in "Phone", with: @requester.phone
    fill_in "State", with: @requester.state
    fill_in "Street address", with: @requester.street_address
    fill_in "Underage", with: @requester.underage
    fill_in "Zip", with: @requester.zip
    click_on "Update Requester"

    assert_text "Requester was successfully updated"
    click_on "Back"
  end

  test "destroying a Requester" do
    visit requesters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Requester was successfully destroyed"
  end
end
