# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[contact]

  def index; end

  def contact
    render :contact, layout: 'embed'
  end

  def admin
    render :admin, layout: 'application_sidebar'
  end
end
