class BoxAssemblyController < ApplicationController

  def new
  end

  def claim
    @box = box_claim_scope.find(params[:box_id])
    @box.assembled_by = current_user
    @box.save!
  end

  def mark_as_assembled
    @box = box_claim_scope.where(assembled_by: current_user).find(params[:box_id])
    @box.update(box_design_params)
  end

  private

  def box_assembly_params
    require(:box)
  end

  def box_claim_scope
    policy_scope(Box, policy_scope_class: BoxPolicy::AssemblyScope)
  end
end
