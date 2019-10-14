require 'rails_helper'

RSpec.describe BoxRequestTriageController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }

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
      zip: Faker::Address.zip,
      abuse_types: ["emotional"]
    }
  }

  describe "POST #create" do
    it "will complain if no data is submitted" do
      post :create

      expect(response.successful?).to be_falsey
    end

    it "will save a Requester" do
      expected_email = test_data[:email]
      expected_county= test_data[:county]

      post :create, :params => { :boxRequest => test_data }

      requester = Requester.last

      expect(requester.email).to eql(expected_email)
      expect(requester.county).to eql(expected_county)
    end

    it "will create a BoxRequest" do
      expected_summary = test_data[:summary]
      expected_counseling = test_data[:is_interested_in_counseling_services]

      post :create, :params => { :boxRequest => test_data }

      box_request = BoxRequest.last

      expect(box_request.summary).to eql(expected_summary)
      expect(box_request.is_interested_in_counseling_services).to eql(expected_counseling)
    end

    it "will email requester and volunteer if ok_to_email is true " do
      allow(AutoEmailHandler).to receive(:new)
      user.volunteer.update_attributes(ok_to_email: true)
      post :create, :params => { :boxRequest => test_data }
      box_request = BoxRequest.last
      expect(AutoEmailHandler).to have_received(:new).with("requester", box_request, user)
      expect(AutoEmailHandler).to have_received(:new).with("volunteer", box_request, user)
    end

    it "will email requester and not email volunteer " do
      allow(AutoEmailHandler).to receive(:new)
      user.volunteer.update_attributes(ok_to_email: false)
      post :create, :params => { :boxRequest => test_data }
      box_request = BoxRequest.last
      expect(AutoEmailHandler).to have_received(:new).with("requester", box_request, user)
      expect(AutoEmailHandler).to_not have_received(:new).with("volunteer", box_request, user)
    end

    it "will email volunteer and not email requester " do
      allow(AutoEmailHandler).to receive(:new)
      user.volunteer.update_attributes(ok_to_email: true)
      test_data[:ok_to_email] = false
      post :create, :params => { :boxRequest => test_data }
      box_request = BoxRequest.last
      expect(AutoEmailHandler).to_not have_received(:new).with("requester", box_request, user)
      expect(AutoEmailHandler).to have_received(:new).with("volunteer", box_request, user)
    end

    it "will not email both volunteer and requester if ok_to_email is false " do
      allow(AutoEmailHandler).to receive(:new)
      user.volunteer.update_attributes(ok_to_email: false)
      test_data[:ok_to_email] = false
      post :create, :params => { :boxRequest => test_data }
      box_request = BoxRequest.last
      expect(AutoEmailHandler).to_not have_received(:new).with("requester", box_request, user)
      expect(AutoEmailHandler).to_not have_received(:new).with("volunteer", box_request, user)
    end

    it "returns redirect_url with a succesful submission" do
      post :create, :params => { :boxRequest => test_data }
      expect(JSON.parse(response.body)).to include("redirect_url" => box_request_thank_you_path)
    end

    it "returns error with an invalid email" do
      test_data[:email] = "invalidemail"

      post :create, :params => { :boxRequest => test_data }
      expect(JSON.parse(response.body)).to include("error")
    end
  end
end
