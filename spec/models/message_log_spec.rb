# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessageLog, type: :model do
  subject(:message_log) do
    MessageLog.new(
      content: 'Content Test',
      messageable_type: 'type',
      messageable_id: 1,
      message_channel: 'email',
      message_type: 'followup_email',
      subject_line: 'subject'
    )
  end

  describe 'attributes' do
    it 'responds to attributes' do
      expected_attributes = {
        content: 'Content Test',
        messageable_type: 'type',
        messageable_id: 1,
        message_channel: 'email',
        message_type: 'followup_email',
        subject_line: 'subject'
      }
      expect(message_log).to have_attributes(expected_attributes)
    end

    describe 'scopes' do
      it 'returns ordered in descending order of creation' do
        volunteer = build(:volunteer, id: 1)
        first = create(:message_log, messageable: volunteer, sendable: volunteer)
        second = create(:message_log, messageable: volunteer, sendable: volunteer)

        expect(MessageLog.ordered).to eq([second, first])
      end
    end
  end
end
