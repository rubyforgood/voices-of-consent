require 'rails_helper'

RSpec.describe "message_logs/index", type: :view do
  let(:sent_to) { create(:user) }
  let(:sent_by) { create(:user) }

  before(:each) do
    @message_logs = [
      create(:message_log,
            messageable: create(:box_request),
            content: "MyText",
            delivery_type: 3,
            delivery_status: "Delivery Status",
            sent_to: sent_to,
            sent_by: sent_by
      ),
      create(:message_log,
            messageable: create(:box_request),
            content: "MyText",
            delivery_type: 3,
            delivery_status: "Delivery Status",
            sent_to: sent_to,
            sent_by: sent_by
      )
    ]
  end

  it "renders a list of message_logs" do
    render
    assert_select "tr>td", :text => "BoxRequest".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Delivery Status".to_s, :count => 2
    assert_select "tr>td", :text => sent_to.id.to_s, :count => 2
    assert_select "tr>td", :text => sent_by.id.to_s, :count => 2
  end
end
