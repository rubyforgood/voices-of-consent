module AuthenticationHelpers
  def login(user = FactoryBot.create(:user))
    user.update_attributes(password: 'password', password_confirmation: 'password')

    visit user_session_path
    fill_in :user_email, with: user.email
    fill_in :user_password, with: 'password'
    click_on 'commit'
  end
end
