require 'rails_helper'

RSpec.describe Box, :type => :model do
  let(:requester) { Requester.new(first_name: "Jane", last_name: "Doe", street_address: "122 Boggie Woogie Avenue", city: "Fairfax", state: "VA", zip: "22030", ok_to_email: true, ok_to_text: false, ok_to_call: false, ok_to_mail: true, underage: false) }
  let(:box_request_1) {
    BoxRequest.create(requester: requester,
                      summary: "Lorem ipsum text.... Caramels tart sweet pudding pie candy lollipop.",
                      question_re_affect: "Lorem ipsum text.... Tart jujubes candy canes pudding I love gummies.",
                      question_re_current_situation: "Sweet roll cake pastry cookie.",
                      question_re_referral_source: "Ice cream sesame snaps danish marzipan macaroon icing jelly beans.") }

  let(:reviewer) { create(:user, :reviewer) }
  let(:designer) { create(:user, :designer) }
  let(:researcher) { create(:user, :researcher) }
  let(:assembler) { create(:user, :assembler) }
  let(:shipper) { create(:user, :shipper) }
  let(:follow_upper) { create(:user, :follow_upper) }
  let(:inventory_type_research_needed) { create(:inventory_type, requires_research: true) }
  let(:inventory_type_no_research_needed) { create(:inventory_type, requires_research: false) }
  let(:box_request) { create(:box_request, :has_reviewer) }
  let(:reviewed_box_request) { create(:box_request, :review_complete) }
  let(:box) { create(:box, :is_designed)  }

  describe "state transitions" do
    before(:each) do
      allow(AutoEmailHandler).to receive(:new)
    end

    it "has state reviewed after box_request is reviewed" do
      box_request.claim_review!
      box_request.complete_review!
      box = box_request.box
      expect(box.aasm_state).to eq("reviewed")
    end

    it "transitions from reviewed to design_in_progress" do
      box = reviewed_box_request.box
      box.designed_by_id = designer.id;
      box.save
      expect(box).to transition_from(:reviewed).to(:design_in_progress).on_event(:claim_design)
    end

    it "transitions from design_in_progress to designed" do
      box_request_1.reviewed_by_id = reviewer.id;
      box_request_1.save
      box_request_1.claim_review!
      box_request_1.complete_review!
      box = box_request_1.box
      allow(box).to receive(:send_research_solicitation_email!)
      box.designed_by_id = designer.id;
      box.save
      box.claim_design!
      box.check_has_box_items # make sure there are items
      # make sure at least one item needs research
      create(:box_item, box: box, inventory_type: inventory_type_research_needed)
      expect(box).to transition_from(:design_in_progress).to(:designed).on_event(:complete_design)
      expect(box).to have_received(:send_research_solicitation_email!)
    end

    it "transitions from design_in_progress to researched when research not needed" do
      box_request_1.reviewed_by_id = reviewer.id;
      box_request_1.save
      box_request_1.claim_review!
      box_request_1.complete_review!
      box = box_request_1.box
      allow(box).to receive(:send_assembly_solicitation_email!)
      box.designed_by_id = designer.id;
      box.save
      box.claim_design!
      box.check_has_box_items # make sure there are items
      # make sure at least one item needs research
      create(:box_item, box: box, inventory_type: inventory_type_no_research_needed)
      expect(box).to transition_from(:design_in_progress).to(:researched).on_event(:complete_design)
      expect(box).to have_received(:send_assembly_solicitation_email!)
    end

    it "transitions from designed to research_in_progress" do
      box_request_1.reviewed_by_id = reviewer.id;
      box_request_1.save
      box_request_1.claim_review!
      box_request_1.complete_review!
      box = box_request_1.box
      box.designed_by_id = designer.id;
      box.save
      box.claim_design!
      box.check_has_box_items # make sure there are items
      # make sure at least one item needs research
      create(:box_item, box: box, inventory_type: inventory_type_research_needed)
      box.complete_design!
      box.researched_by_id = researcher.id;
      box.save
      expect(box).to transition_from(:designed).to(:research_in_progress).on_event(:claim_research)
    end

    it "transitions from research_in_progress to researched" do
      time_now = Time.parse("Oct 11 2019")
      allow(Time).to receive(:now).and_return(time_now)

      box_request_1.reviewed_by_id = reviewer.id;
      box_request_1.save
      box_request_1.claim_review!
      box_request_1.complete_review!
      box = box_request_1.box
      box.designed_by_id = designer.id;
      box.save
      box.claim_design!
      box.check_has_box_items # make sure there are items
      expect(box).to receive(:send_research_solicitation_email!).and_return(true)

      # make sure at least one item needs research
      create(:box_item, box: box, inventory_type: inventory_type_research_needed)
      box.complete_design!
      box.researched_by_id = researcher.id;
      box.save
      box.claim_research!
      box.mark_box_items_as_researched!
      expect(box).to transition_from(:research_in_progress).to(:researched).on_event(:complete_research)
      expect(box.researched_at).to eq(time_now)
    end

    it "transitions from researched to assembly in progress" do
      box_request_1.reviewed_by_id = reviewer.id;
      box_request_1.save
      box_request_1.claim_review!
      box_request_1.complete_review!
      box = box_request_1.box
      box.designed_by_id = designer.id;
      box.save
      box.claim_design!
      box.check_has_box_items # make sure there are items
      # make sure at least one item needs research
      create(:box_item, box: box, inventory_type: inventory_type_research_needed)
      box.complete_design!
      box.researched_by_id = researcher.id;
      box.save
      box.claim_research!
      box.mark_box_items_as_researched!
      box.complete_research!
      box.assembled_by_id = assembler.id;
      box.save
      expect(box).to transition_from(:researched).to(:assembly_in_progress).on_event(:claim_assembly)
    end

    it "transitons from assembly_in_progress to assembled" do
      box_request_1.reviewed_by_id = reviewer.id;
      box_request_1.save
      box_request_1.claim_review!
      box_request_1.complete_review!
      box = box_request_1.box
      allow(box).to receive(:send_shipping_solicitation_email!)
      box.designed_by_id = designer.id;
      box.save
      box.claim_design!
      box.check_has_box_items # make sure there are items
      # make sure at least one item needs research
      create(:box_item, box: box, inventory_type: inventory_type_research_needed)
      box.complete_design!
      box.researched_by_id = researcher.id;
      box.save
      box.claim_research!
      box.mark_box_items_as_researched!
      box.complete_research!
      box.assembled_by_id = assembler.id;
      box.save
      box.claim_assembly!
      expect(box).to transition_from(:assembly_in_progress).to(:assembled).on_event(:complete_assembly)
      expect(box).to have_received(:send_shipping_solicitation_email!)
    end

    it "transitons from assembled to shipping_in_progress" do
      box_request_1.reviewed_by_id = reviewer.id;
      box_request_1.save
      box_request_1.claim_review!
      box_request_1.complete_review!
      box = box_request_1.box
      box.designed_by_id = designer.id;
      box.save
      box.claim_design!
      box.check_has_box_items # make sure there are items
      # make sure at least one item needs research
      create(:box_item, box: box, inventory_type: inventory_type_research_needed)
      box.complete_design!
      box.researched_by_id = researcher.id;
      box.save
      box.claim_research!
      box.mark_box_items_as_researched!
      box.complete_research!
      box.assembled_by_id = assembler.id;
      box.save
      box.claim_assembly!
      box.shipped_by_id = shipper.id;
      box.save
      box.complete_assembly!
      expect(box).to transition_from(:assembled).to(:shipping_in_progress).on_event(:claim_shipping)
    end

    it "transitons from shipping in progress to shipped" do
      box_request_1.reviewed_by_id = reviewer.id;
      box_request_1.save
      box_request_1.claim_review!
      box_request_1.complete_review!
      box = box_request_1.box
      box.designed_by_id = designer.id;
      box.save
      box.claim_design!
      box.check_has_box_items # make sure there are items
      # make sure at least one item needs research
      create(:box_item, box: box, inventory_type: inventory_type_research_needed)
      box.complete_design!
      box.researched_by_id = researcher.id;
      box.save
      box.claim_research!
      box.mark_box_items_as_researched!
      box.complete_research!
      box.assembled_by_id = assembler.id;
      box.save
      box.claim_assembly!
      box.shipped_by_id = shipper.id;
      box.save
      box.complete_assembly!
      box.claim_shipping!
      expect(box).to transition_from(:shipping_in_progress).to(:shipped).on_event(:complete_shipping)
    end

    it "transitons from shipped to follow_up_in_progress" do
      box_request_1.reviewed_by_id = reviewer.id;
      box_request_1.save
      box_request_1.claim_review!
      box_request_1.complete_review!
      box = box_request_1.box
      box.designed_by_id = designer.id;
      box.save
      box.claim_design!
      box.check_has_box_items # make sure there are items
      # make sure at least one item needs research
      create(:box_item, box: box, inventory_type: inventory_type_research_needed)
      box.complete_design!
      box.researched_by_id = researcher.id;
      box.save
      box.claim_research!
      box.mark_box_items_as_researched!
      box.complete_research!
      box.assembled_by_id = assembler.id;
      box.save
      box.claim_assembly!
      box.shipped_by_id = shipper.id;
      box.save
      box.complete_assembly!
      box.claim_shipping!
      box.followed_up_by_id = follow_upper.id;
      box.save
      expect(box).to transition_from(:shipped).to(:follow_up_in_progress).on_event(:claim_follow_up)
    end

    it "transitons from follow_up_in_progress to followed up" do
      box_request_1.reviewed_by_id = reviewer.id;
      box_request_1.save
      box_request_1.claim_review!
      box_request_1.complete_review!
      box = box_request_1.box
      box.designed_by_id = designer.id;
      box.save
      box.claim_design!
      box.check_has_box_items # make sure there are items
      # make sure at least one item needs research
      create(:box_item, box: box, inventory_type: inventory_type_research_needed)
      box.complete_design!
      box.researched_by_id = researcher.id;
      box.save
      box.claim_research!
      box.mark_box_items_as_researched!
      box.complete_research!
      box.assembled_by_id = assembler.id;
      box.save
      box.claim_assembly!
      box.shipped_by_id = shipper.id;
      box.save
      box.complete_assembly!
      box.claim_shipping!
      box.complete_shipping!
      box.followed_up_by_id = follow_upper.id;
      box.save
      box.claim_follow_up!
      expect(box).to transition_from(:follow_up_in_progress).to(:followed_up).on_event(:complete_follow_up)
    end
  end

  describe Box, "#send_research_solicitation_email!" do
    it "sends an email with the AutoEmailHandler" do
      box = create(:box, designed_by: designer)
      allow(AutoEmailHandler).to receive(:new)

      box.send_research_solicitation_email!

      expect(AutoEmailHandler).to have_received(:new).with(
          "volunteer",
          box,
          designer,
      )
    end
  end

  describe Box, "#send_assembly_solicitation_email!" do
    it "sends an email with the AutoEmailHandler" do
      box = create(:box, researched_by: researcher)
      allow(AutoEmailHandler).to receive(:new)

      box.send_assembly_solicitation_email!
    end
  end

  describe Box, "#send_shipping_solicitation_email!" do
    it "sends a email with AutoEmailHandler" do
      box = create(:box, assembled_by: assembler)
      allow(AutoEmailHandler).to receive(:new)

      box.send_shipping_solicitation_email!

      expect(AutoEmailHandler).to have_received(:new).with(
          "volunteer",
          box,
          box.assembled_by,
      )
    end
  end

  it { 
    is_expected.to belong_to(:assembly_location)
    .class_name('Location')
    .optional,
    inverse_of: :assembled_boxes 
  }
end
