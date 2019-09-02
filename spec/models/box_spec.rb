require 'rails_helper'

RSpec.describe Box, :type => :model do
  subject(:requester) { Requester.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false) }
  subject(:volunteer) { Volunteer.create(first_name: "John", last_name: "Doe", street_address: "123 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false) }
  subject(:user) { User.create!(email: "lorem@ipsum.com", password: "5938djamro", volunteer_id: volunteer.id  ) }
  subject(:box_request_1) { 
    BoxRequest.create(requester: requester, 
      summary: "Lorem ipsum text.... Caramels tart sweet pudding pie candy lollipop.",
      question_re_affect: "Lorem ipsum text.... Tart jujubes candy canes pudding I love gummies.",
      question_re_current_situation: "Sweet roll cake pastry cookie.",
      question_re_referral_source: "Ice cream sesame snaps danish marzipan macaroon icing jelly beans." ) }
  subject(:box) { box_request_1.create_box }


  describe "state transitions" do

    before :each do
      box.save
    end

    it "has state design_in_progress after box_request is reviewed" do
      box_request_1.reviewed_by_id = user.id;   
      box_request_1.save
      box_request_1.review
      box_request_1.end_review
      expect(box).to transition_from(:pending_review).to(:design_in_progress).on_event(:initialize_design)
    end

    it "transitions from design_in_progress to designed" do
      box.initialize_design
      box.designed_by_id = 3;
      box.designed_at = DateTime.now
      box.save
      box.design
      expect(box).to transition_from(:design_in_progress).to(:designed).on_event(:design)
    end

    it "transitions from designed to assembly in progress" do
      box.initialize_design
      box.designed_by_id = 3;
      box.designed_at = DateTime.now
      box.design
      box.assembled_by_id = 6;
      box.save
      box.assembling
      expect(box).to transition_from(:designed).to(:assembly_in_progress).on_event(:assembling)
    end

    it "transitons from assembly in progress to assembled" do
      box.initialize_design
      box.designed_by_id = 3;
      box.designed_at = DateTime.now
      box.design
      box.assembled_by_id = 6;
      box.assembling
      box.assemble
      expect(box).to transition_from(:assembly_in_progress).to(:assembled).on_event(:assemble)
    end

    it "transitons from assembled to shipping in progress" do
      box.initialize_design
      box.designed_by_id = 3;
      box.designed_at = DateTime.now
      box.design
      box.assembled_by_id = 6;
      box.assembling
      box.assemble
      box.shipped_by_id = 8;
      box.shipping
      expect(box).to transition_from(:assembled).to(:shipping_in_progress).on_event(:shipping)
    end

    it "transitons from shipping in progress to shipped" do
      box.initialize_design
      box.designed_by_id = 3;
      box.designed_at = DateTime.now
      box.design
      box.assembled_by_id = 6;
      box.assembling
      box.assemble
      box.shipped_by_id = 8;
      box.shipping
      box.shipped_at = DateTime.now
      box.ship
      expect(box).to transition_from(:shipping_in_progress).to(:shipped).on_event(:ship)
    end

  end



end