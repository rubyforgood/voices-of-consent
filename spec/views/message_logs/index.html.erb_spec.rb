require 'rails_helper'

RSpec.describe "message_logs/index", type: :view do
  before(:each) do
    @messageable_1 = create(:messageable)
    @messageable_2 = create(:messageable)
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
        sent_to: create(:user, volunteer: @volunteer_1),
        sent_by: create(:user, volunteer: @volunteer_2),
      ),
      create(
        :message_log,
        messageable: @messageable_2,
        content: "MyContent 2",
        delivery_type: "email",
        delivery_status: "Delivery Status 2",
        sent_to: create(:user, volunteer: @volunteer_3),
        sent_by: create(:user, volunteer: @volunteer_4),
      ),
    ]
  end

  it "renders a list of message_logs" do
    render

    assert_select "tr>td", :text => "BoxRequest", :count => 2
    assert_select "tr>td", :text => @messageable_1.id.to_s, :count => 1
    assert_select "tr>td", :text => "MyContent 1", :count => 1
    assert_select "tr>td", :text => "phone", :count => 1
    assert_select "tr>td", :text => "Delivery Status 1", :count => 1
    assert_select "tr>td", :text => @volunteer_1.name, :count => 1
    assert_select "tr>td", :text => @volunteer_2.name, :count => 1

    assert_select "tr>td", :text => "BoxRequest", :count => 2
    assert_select "tr>td", :text => @messageable_2.id.to_s, :count => 1
    assert_select "tr>td", :text => "MyContent 2", :count => 1
    assert_select "tr>td", :text => "email", :count => 1
    assert_select "tr>td", :text => "Delivery Status 2", :count => 1
    assert_select "tr>td", :text => @volunteer_3.name, :count => 1
    assert_select "tr>td", :text => @volunteer_4.name, :count => 1
  end
end
