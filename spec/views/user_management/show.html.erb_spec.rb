require 'rails_helper'

RSpec.describe "user_management/show.html.erb", type: :view do
  context 'renders columns correctly' do
    it 'renders columns' do
      render
      assert_select "a[href='/users/invitation/new']", :text => 'Invite a New User'
      assert_select "tr>th", :text => 'Email'
      assert_select "tr>th", :text => 'Invited and accepted?'
   end
  end

  context 'user not invited' do
    let!(:user_not_invited) { create(:user) }

    it 'renders user not invited' do
      render
      assert_select "tr>td", :text => "#{user_not_invited.email}"
      assert_select "tr>td", :text => "Not Invited"
    end
  end

  context 'user invited' do
    let!(:user_invited) { create(:user, invitation_sent_at: Time.current) }

    it 'renders the invitation' do
      render
      assert_select "tr>td", :text => "#{user_invited.email}"
      assert_select "tr>td", :text => "Invited but not Accepted yet"
    end
  end

  context 'user invited' do
   let!(:user_accepted) { create(:user, invitation_accepted_at: Time.current) }

    it 'renders the invitation as accepted' do
      render
      assert_select "tr>td", :text => "#{user_accepted.email}"
      assert_select "tr>td", :text => "Invited and Accepted"
    end
  end
end
