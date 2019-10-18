# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BoxRequest, type: :model do
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
  subject(:box_request) { BoxRequest.new }
  subject(:user) { create(:user) }

  describe 'box request' do
    it 'is valid with valid attributes' do
      box_request.requester = requester

      box_request.summary = 'Lorem ipsum text.'
      box_request.question_re_affect = 'Lorem ipsum text. '
      box_request.question_re_current_situation = 'Sweet roll cake.'
      box_request.question_re_referral_source = 'Ice cream.'

      expect(box_request).to be_valid
    end

    it 'is invalid without requester' do
      box_request.summary = 'Lorem ipsum text.'
      box_request.question_re_affect = 'Lorem ipsum text. '
      box_request.question_re_current_situation = 'Sweet roll cake.'
      box_request.question_re_referral_source = 'Ice cream.'

      expect(box_request).to_not be_valid
    end

    it 'is invalid without question_re_affect' do
      box_request.requester = requester

      box_request.summary = 'Lorem ipsum text. '
      box_request.question_re_current_situation = 'Sweet roll cake.'
      box_request.question_re_referral_source = 'Ice cream.'

      expect(box_request).to_not be_valid
    end

    it 'is invalid without question_re_current_situation' do
      box_request.requester = requester

      box_request.summary = 'Lorem ipsum text. '
      box_request.question_re_affect = 'Sweet roll cake.'
      box_request.question_re_referral_source = 'Ice cream.'

      expect(box_request).to_not be_valid
    end

    it 'is invalid without question_re_referral_source' do
      box_request.requester = requester

      box_request.summary = 'Lorem ipsum text. '
      box_request.question_re_affect = 'Sweet roll cake.'
      box_request.question_re_current_situation = 'Ice cream.'

      expect(box_request).to_not be_valid
    end

    it 'adds a tag' do
      box_request.requester = requester

      box_request.summary = 'Lorem ipsum text.'
      box_request.question_re_affect = 'Lorem ipsum text. '
      box_request.question_re_current_situation = 'Sweet roll cake.'
      box_request.question_re_referral_source = 'Ice cream.'

      box_request.tag_list.add('free_counseling')
      box_request.save
      box_request.reload
      expect(box_request.tags[0].name).to eq('free_counseling')
    end

    it 'removes a tag' do
      box_request.requester = requester

      box_request.summary = 'Lorem ipsum text.'
      box_request.question_re_affect = 'Lorem ipsum text.'
      box_request.question_re_current_situation = 'Sweet roll cake.'
      box_request.question_re_referral_source = 'Ice cream.'

      box_request.tag_list.add('free_counseling')
      box_request.save

      box_request.tag_list.remove('free_counseling')
      box_request.save
      box_request.reload

      expect(box_request.tags).to eq([])
    end
  end

  describe 'state transitions' do
    before :each do
      box_request.requester = requester
      box_request.summary = 'Lorem ipsum text.'
      box_request.question_re_affect = 'Lorem ipsum text.'
      box_request.question_re_current_situation = 'Sweet roll cake.'
      box_request.question_re_referral_source = 'Ice cream.'
      box_request.save
    end

    it 'new box request initializes with state requested' do
      expect(box_request).to have_state(:requested)
    end

    it 'transitions from requested to review in progress' do
      box_request.reviewed_by_id = user.id
      box_request.claim_review

      expect(box_request).to transition_from(:requested)
        .to(:review_in_progress)
        .on_event(:claim_review)
    end

    it 'transitions from review in progress to reviewed' do
      box_request.reviewed_by_id = user.id
      box_request.reviewed_at = DateTime.now
      @box = Box.create(box_request_id: box_request.id)
      box_request.claim_review
      box_request.complete_review
      expect(box_request).to transition_from(:review_in_progress)
        .to(:reviewed)
        .on_event(:complete_review)
    end

    it 'triggers initial state on box model if review is successful' do
      box_request.reviewed_by_id = user.id
      @box = Box.create(box_request_id: box_request.id)
      box_request.reviewed_at = DateTime.now
      box_request.claim_review
      box_request.complete_review
      box_request.box.claim_design
      expect(box_request.box).to have_state(:design_in_progress)
    end
  end
end
