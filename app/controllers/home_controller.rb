class HomeController < ApplicationController

  def index
  end

  def contact
    render :contact, layout: 'embed'
  end

  def admin
    render :admin, layout: 'application_sidebar'
  end
end
