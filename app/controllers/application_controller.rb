# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

  layout 'application_full'

  private

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end
