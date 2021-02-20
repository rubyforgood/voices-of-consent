class UnauthenticatedController < ApplicationController
  skip_before_action :authenticate_user!

  layout 'application_unauthenticated'
end
