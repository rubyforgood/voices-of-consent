# frozen_string_literal: true

class Users::InvitationsController < Devise::InvitationsController
  def after_invite_path_for(_inviter, _invitee)
    user_management_path
  end

  def after_accept_path_for(_resource)
    new_volunteer_path
  end
end
