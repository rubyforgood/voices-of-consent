# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Box, type: :model do
  subject(:requester) do
    Requester.new(
      first_name: 'Jane',
      last_name: 'Doe',
      street_address: '122 Boggie Woogie Avenue',
      city: 'Fairfax',
      state: 'VA',
      zip: '22030',
      ok_to_email: true,
      ok_to_text: false,
      ok_to_call: false,
      ok_to_mail: true,
      underage: false
    )
  end
  subject(:volunteer) do
    Volunteer.create(
      first_name: 'John',
      last_name: 'Doe',
      street_address: '123 Boggie Woogie Avenue',
      city: 'Fairfax',
      state: 'VA',
      zip: '22030',
      ok_to_email: true,
      ok_to_text: false,
      ok_to_call: false,
      ok_to_mail: true,
      underage: false
    )
  end
  subject(:user) { create(:user) }
  subject(:box_request_1) do
    BoxRequest.create(
      requester: requester,
      summary: 'Lorem ipsum text.',
      question_re_affect: 'Lorem ipsum text.',
      question_re_current_situation: 'Sweet roll.',
      question_re_referral_source: 'Ice cream.'
    )
  end
  subject(:box) { box_request_1.create_box }
  let(:box_reviewed) do
    box_request_1.reviewed_by_id = user.id
    box_request_1.save
    box_request_1.reviewed_at = DateTime.now
    box_request_1.claim_review
    box_request_1.complete_review
    box_request_1.box.claim_design
  end

  describe 'state transitions' do
    before :each do
      box.save
    end

    it 'has state design_in_progress after box_request is reviewed' do
      box_reviewed
      expect(box).to transition_from(:reviewed)
        .to(:design_in_progress)
        .on_event(:claim_design)
    end

    it 'transitions from design_in_progress to researched' do
      box_reviewed
      box.designed_by_id = user.id
      box.designed_at = DateTime.now
      box.complete_design
      expect(box).to transition_from(:design_in_progress)
        .to(:researched)
        .on_event(:complete_design)
    end

    it 'transitions from researched to assembly in progress' do
      box_reviewed
      box.designed_by_id = user.id
      box.designed_at = DateTime.now
      box.complete_design
      box.assembled_by_id = user.id
      box.claim_assembly
      expect(box).to transition_from(:researched)
        .to(:assembly_in_progress)
        .on_event(:claim_assembly)
    end

    it 'transitons from assembly in progress to assembled' do
      box_reviewed
      box.designed_by_id = user.id
      box.designed_at = DateTime.now
      box.complete_design
      box.assembled_by_id = user.id
      box.claim_assembly
      box.assembled_at = DateTime.now
      box.complete_assembly
      expect(box).to transition_from(:assembly_in_progress)
        .to(:assembled)
        .on_event(:complete_assembly)
    end

    it 'transitons from assembled to shipping in progress' do
      box_reviewed
      box.designed_by_id = user.id
      box.designed_at = DateTime.now
      box.complete_design
      box.assembled_by_id = user.id
      box.claim_assembly
      box.assembled_at = DateTime.now
      box.complete_assembly
      box.shipped_by_id = 8
      box.claim_shipping
      expect(box).to transition_from(:assembled)
        .to(:shipping_in_progress)
        .on_event(:claim_shipping)
    end

    it 'transitons from shipping in progress to shipped' do
      box_reviewed
      box.designed_by_id = user.id
      box.designed_at = DateTime.now
      box.complete_design
      box.assembled_by_id = user.id
      box.claim_assembly
      box.assembled_at = DateTime.now
      box.complete_assembly
      box.shipped_by_id = user.id
      box.claim_shipping
      box.shipped_at = DateTime.now
      box.complete_shipping
      expect(box).to transition_from(:shipping_in_progress)
        .to(:shipped)
        .on_event(:complete_shipping)
    end
  end
end
