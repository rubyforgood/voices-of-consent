require 'rails_helper'

RSpec.describe "user_management/show.html.erb", type: :view do
  before(:each) do
    @user_not_invited = create(:user)
  end

  it 'renders columns' do
    render
    assert_select "a[href='/users/invitation/new']", :text => 'Invite a New User'
    assert_select "tr>th", :text => 'Email'
    assert_select "tr>th", :text => 'Invited and accepted?'
    assert_select "tr>td", :text => "#{@user_not_invited.email}"
    assert_select "tr>td", :text => "Not Invited"
  end
end
