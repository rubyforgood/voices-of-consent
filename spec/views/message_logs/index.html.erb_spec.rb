require 'rails_helper'

RSpec.describe "message_logs/index", type: :view do
  before(:each) do
    assign(:message_logs, [
      MessageLog.create!(
        :messageable_type => "BoxRequest",
        :messageable_id => 2,
        :content => "MyText",
        :delivery_type => 3,
        :delivery_status => "Delivery Status",
        :sent_to_id => 4,
        :sent_by_id => 5
      ),
      MessageLog.create!(
        :messageable_type => "BoxRequest",
        :messageable_id => 2,
        :content => "MyText",
        :delivery_type => 3,
        :delivery_status => "Delivery Status",
        :sent_to_id => 4,
        :sent_by_id => 5
      )
    ])
  end

  it "renders a list of message_logs" do
    render
    assert_select "tr>td", :text => "BoxRequest".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Delivery Status".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
