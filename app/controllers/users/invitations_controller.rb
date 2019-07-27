class Users::InvitationsController < Devise::InvitationsController
  def after_invite_path_for(inviter, invitee)
    user_management_path
  end

  def after_accept_path_for(resource)
    new_volunteer_path
  end
end
