class HomeController < ApplicationController
  def index
  end

  def contact
  end

  def admin
    render :admin, layout: 'application_sidebar'
  end
end
