class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  layout 'application_full'
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end
