require 'rails_helper'

RSpec.describe "message_logs/show", type: :view do
  let(:sent_to) { create(:user) }
  let(:sent_by) { create(:user) }

  before(:each) do
    messageable = create(:box_request)
    @message_log = create(:message_log,
                          messageable_type: "BoxRequest",
                          messageable_id: messageable.id,
                          content: "MyText",
                          delivery_type: 3,
                          delivery_status: "Delivery Status",
                          sent_to: sent_to,
                          sent_by: sent_by
    )
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/messageable type/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/phone/)
    expect(rendered).to match(/Delivery Status/)
    expect(rendered).to match(Regexp.new(sent_to.id.to_s))
    expect(rendered).to match(Regexp.new(sent_by.id.to_s))
  end
end
