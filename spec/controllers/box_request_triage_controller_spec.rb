require 'rails_helper'

RSpec.describe BoxRequestTriageController, type: :controller do
  let(:test_data) {
    {
      city: Faker::Address.city,
      county: Faker::Address.community,
      email: Faker::Internet.email,
      first_name: Faker::Name.first_name,
      is_interested_in_counseling_services: true,
      is_interested_in_health_services: nil,
      is_safe: nil,
      is_underage: false,
      last_name: Faker::Name.last_name,
      ok_to_call: true,
      ok_to_email: true,
      ok_to_mail: true,
      ok_to_text: true,
      phone: "",
      question_re_affect: "question about affect",
      question_re_current_situation: "question about current situation",
      question_re_if_not_self_completed: "question if not self completed",
      question_re_referral_source: "question about referral source",
      state: Faker::Address.state,
      street_address: Faker::Address.street_address,
      summary: "sample summary",
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

    it "will create a BoxRequest" do
      expected_summary = test_data[:summary]
      expected_counseling = test_data[:is_interested_in_counseling_services]

      post :create, :params => { :boxRequest => test_data.to_json }

      box_request = BoxRequest.last

      expect(box_request.summary).to eql(expected_summary)
      expect(box_request.is_interested_in_counseling_services).to eql(expected_counseling)
    end

  end
end