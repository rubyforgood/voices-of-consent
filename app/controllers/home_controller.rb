class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:contact]

  def index
    filters = InventoryDateFilter.call(permitted_params.to_h)

    @presenter = ::InventoryDashboardPresenter.new(**filters)
  end

  def contact
    render :contact, layout: 'embed'
  end

  def admin
    render :admin, layout: 'application_sidebar'
  end

  private

  def permitted_params
    params.permit(inventory: [:start_date, :end_date])
  end
end
