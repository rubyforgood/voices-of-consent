class ApplicationController < ActionController::Base
  include Pundit
  before_action :store_user_location!, if: :storable_location?
  protect_from_forgery
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
