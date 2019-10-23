require 'rails_helper'

RSpec.describe "message_logs/index", type: :view do
  before(:each) do
    @messageable_1 = create(:messageable)
    @messageable_2 = create(:messageable)
    @sendable_1 = create(:volunteer)
    @sendable_2 = create(:volunteer)
    @volunteer_1 = create(:volunteer)
    @volunteer_2 = create(:volunteer)
    @volunteer_3 = create(:volunteer)
    @volunteer_4 = create(:volunteer)
    @message_logs = [
        create(
            :message_log,
            messageable: @messageable_1,
            content: "MyContent 1",
            delivery_type: "phone",
            delivery_status: "Delivery Status 1",
            sendable: @sendable_1,
            sent_by: create(:user, volunteer: @volunteer_2),
        ),
        create(
            :message_log,
            messageable: @messageable_2,
            content: "MyContent 2",
            delivery_type: "email",
            delivery_status: "Delivery Status 2",
            sendable: @sendable_2,
            sent_by: create(:user, volunteer: @volunteer_4),
        ),
    ]
  end

  it "renders a list of message_logs" do
    allow(view).to receive_messages(:will_paginate => nil)

    render

    assert_select "tr>td", :text => @message_logs[0].content, :count => 1
    assert_select "tr>td", :text => @message_logs[0].delivery_type, :count => 1
    assert_select "tr>td", :text => @message_logs[0].delivery_status, :count => 1
    assert_select "tr>td", :text => @message_logs[0].sent_by.email, :count => 1


    assert_select "tr>td", :text => @message_logs[1].content, :count => 1
    assert_select "tr>td", :text => @message_logs[1].delivery_type, :count => 1
    assert_select "tr>td", :text => @message_logs[1].delivery_status, :count => 1
    assert_select "tr>td", :text => @message_logs[1].sent_by.email, :count => 1
  end
end
