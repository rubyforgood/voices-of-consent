class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  layout 'application_full'
end
