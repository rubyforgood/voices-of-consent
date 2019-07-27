require 'rails_helper'

RSpec.describe "message_logs/show", type: :view do
  before(:each) do
    @message_log = assign(:message_log, MessageLog.create!(
      :messageable_type => "messageable Type",
      :messageable_id => 2,
      :content => "MyText",
      :delivery_type => 3,
      :delivery_status => "Delivery Status",
      :sent_to_id => 4,
      :sent_by_id => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/messageable Type/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Delivery Status/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
