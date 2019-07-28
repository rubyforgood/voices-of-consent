class HomeController < ApplicationController
before_action :authenticate_user!, only: [:admin]


  def index
  end

  def contact
    render :contact, layout: 'embed'
  end

  def admin
    render :admin, layout: 'application_sidebar'
  end
end
