require 'rails_helper'

RSpec.describe BoxRequestTriageController, type: :controller do
  let(:test_data) {
    {
      city: Faker::Address.city,
      county: Faker::Address.country,
      email: Faker::Internet.email,
      first_name: Faker::Name.first_name,
      is_interested_in_counseling_services: nil,
      is_interested_in_health_services: nil,
      is_safe: nil,
      is_underage: false,
      last_name: Faker::Name.last_name,
      ok_to_call: true,
      ok_to_email: true,
      ok_to_mail: true,
      ok_to_text: true,
      phone: "",
      question_re_affect: "",
      question_re_current_situation: "",
      question_re_if_not_self_completed: "",
      question_re_referral_source: "",
      state: Faker::Address.state,
      street_address: Faker::Address.street_address,
      summary: "",
      zip: Faker::Address.zip
    }
  }

  describe "POST #create" do
    it "will complain if no data is submitted" do
      post :create

      expect(response.success?).to be_falsey
    end

    it "will save an email address" do

      expected_email = test_data[:email]

      post :create, :params => { :boxRequest => test_data.to_json }

      requester = Requester.last

      expect(requester.email).to eql(expected_email)
    end
  end
end