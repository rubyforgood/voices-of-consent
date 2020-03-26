# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VolunteerApplicationController, type: :controller do
  let(:test_data) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      phone: '',
      street_address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip: Faker::Address.zip,
      county: Faker::Address.community,
      marketing_vector: 'friends',
      why_volunteer: 'to help others',
      ok_to_mail: true,
      ok_to_text: true,
      is_underage: false
    }
  end

  describe 'POST #create' do
    it 'will complain if no data is submitted' do
      post :create

      expect(response.successful?).to be_falsey
    end

    it 'will create a volunteer' do
      expected_first_name = test_data[:first_name]
      expected_why_volunteer = test_data[:why_volunteer]
      expected_county = test_data[:county]
      expected_ok_to_mail = test_data[:ok_to_mail]
      expected_ok_to_call = false # Should set default
      post :create, params: { volunteerApplication: test_data }

      volunteer = Volunteer.last

      expect(volunteer.first_name).to eql(expected_first_name)
      expect(volunteer.why_volunteer).to eql(expected_why_volunteer)
      expect(volunteer.county).to eql(expected_county)
      expect(volunteer.ok_to_mail).to eql(expected_ok_to_mail)
      expect(volunteer.ok_to_call).to eql(expected_ok_to_call)
    end

    it 'returns redirect_url with a succesful submission' do
      post :create, params: { volunteerApplication: test_data }
      expect(JSON.parse(response.body)).to include(
        'redirect_url' => volunteers_thank_you_path
      )
    end
  end
end
