class BoxDesignController < ApplicationController
  before_action :authenticate_user!

  def claim
    @box = policy_scope(Box).find(params[:box_id])
    @box.designed_by = current_user
    @box.save!
  end

  def mark_as_designed
    @box = policy_scope(Box).find_by(designed_by: current_user)
    @box.update(box_design_params)
  end

  private

  def box_design_params
    require(:box)
  end
end
