require 'rails_helper'

RSpec.describe MessageLog, type: :model do
 subject(:message_log) { MessageLog.new(content: "Content Test", messageable_type: "type", messageable_id: 11111, message_channel: "email", message_type: "followup_email", subject_line: "subject") }

 describe "attributes" do
  it "responds to attributes content messageable_type subject_line message_channel and message_type" do
    expect(message_log).to have_attributes(content: "Content Test", messageable_type: "type", messageable_id: 11111, message_channel: "email", message_type: "followup_email", subject_line: "subject")
  end
end


end
