class BoxDesignController < ApplicationController

  def new
  end

  def claim
    @box = box_claim_scope.find(params[:box_id])
    @box.designed_by = current_user
    @box.save!
  end

  def mark_as_designed
    @box = box_claim_scope.find_by(designed_by: current_user)
    @box.update(box_design_params)
    @box.design!
  end

  private

  def box_design_params
    require(:box)
  end

  def box_claim_scope
    policy_scope(Box, policy_scope_class: BoxPolicy::DesignScope)
  end
end
