class BoxShipmentController < ApplicationController
  before_action :authenticate_user!

  def claim
    @box = Box.includes(:box_request).find_by_id(params[:box_id])
    @requester = @box.box_request.requester
    #box_claim_scope.find(params[:box_id])
    @box.shipped_by = current_user
    @box.save!
  end

  def mark_as_shipped
    @box = box_claim_scope.find_by(shipped_by: current_user)
    @box.update(box_shipment_params)
  end

  private

  def box_shipment_params
    require(:box)
  end

  def box_claim_scope
    policy_scope(Box, policy_scope_class: BoxPolicy::ShipmentScope)
  end
end
