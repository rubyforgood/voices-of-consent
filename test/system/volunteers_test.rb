require "application_system_test_case"

class VolunteersTest < ApplicationSystemTestCase
  setup do
    @volunteer = volunteers(:one)
  end

  test "visiting the index" do
    visit volunteers_url
    assert_selector "h1", text: "Volunteers"
  end

  test "creating a Volunteer" do
    visit volunteers_url
    click_on "New Volunteer"

    fill_in "City", with: @volunteer.city
    fill_in "County", with: @volunteer.county
    fill_in "First name", with: @volunteer.first_name
    fill_in "Graduation year", with: @volunteer.graduation_year
    fill_in "Last name", with: @volunteer.last_name
    check "Ok to call" if @volunteer.ok_to_call
    check "Ok to email" if @volunteer.ok_to_email
    check "Ok to mail" if @volunteer.ok_to_mail
    check "Ok to text" if @volunteer.ok_to_text
    fill_in "Phone", with: @volunteer.phone
    fill_in "State", with: @volunteer.state
    fill_in "Street address", with: @volunteer.street_address
    check "Underage" if @volunteer.underage
    fill_in "University location", with: @volunteer.university_location_id
    fill_in "Zip", with: @volunteer.zip
    click_on "Create Volunteer"

    assert_text "Volunteer was successfully created"
    click_on "Back"
  end

  test "updating a Volunteer" do
    visit volunteers_url
    click_on "Edit", match: :first

    fill_in "City", with: @volunteer.city
    fill_in "County", with: @volunteer.county
    fill_in "First name", with: @volunteer.first_name
    fill_in "Graduation year", with: @volunteer.graduation_year
    fill_in "Last name", with: @volunteer.last_name
    check "Ok to call" if @volunteer.ok_to_call
    check "Ok to email" if @volunteer.ok_to_email
    check "Ok to mail" if @volunteer.ok_to_mail
    check "Ok to text" if @volunteer.ok_to_text
    fill_in "Phone", with: @volunteer.phone
    fill_in "State", with: @volunteer.state
    fill_in "Street address", with: @volunteer.street_address
    check "Underage" if @volunteer.underage
    fill_in "University location", with: @volunteer.university_location_id
    fill_in "Zip", with: @volunteer.zip
    click_on "Update Volunteer"

    assert_text "Volunteer was successfully updated"
    click_on "Back"
  end

  test "destroying a Volunteer" do
    visit volunteers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Volunteer was successfully destroyed"
  end
end
