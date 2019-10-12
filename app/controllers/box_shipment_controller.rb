class BoxShipmentController < ApplicationController

  def new
    @box = box_claim_scope.find(params[:box_id])
    @requester = @box.box_request.requester
  end

  def claim
    @box = box_claim_scope.find(params[:box_id])

    if !@box.shipped_by_id || @box.shipped_by == current_user
      respond_to do |format|
        @box.shipped_by = current_user
        if @box.save
          if @box.aasm_state == "assembled"
            @box.claim_shipping!
          end

          format.html { redirect_to box_request_claim_thank_you_path(@box.box_request, "assemble"), notice: 'Box design was successfully claimed.' }
          format.json { render :show, status: :ok, location: @box }
        else
          format.html { render :edit }
          format.json { render json: @box.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to box_request_already_claimed_path
    end
  end

  def decline
    @box = request_review_scope.find(params[:box_id])
    if @box.shipped_by != current_user

      respond_to do |format|
        if @box.decline_shipping!
          format.html { redirect_to box_request_decline_thank_you_path(id: @box.box_request, phase: "shipping") }
          format.json { render :show, status: :ok, location: @box }
        else

          format.html { redirect_to root_path, alert: 'Box shipping decline failed.' }
          format.json { render :show, status: :ok, location: @box }
        end
      end
    else
      redirect_to edit_box_path(@box), notice: "You previously claimed shipping of this Box"
    end
  end

  def complete
    @box = box_claim_scope.find(params[:box_id])

    respond_to do |format|
      @box.shipped_by = current_user if @box.shipped_by_id == nil

      if @box.save
        if @box.aasm_state == "researched"
          @box.claim_shipping!
          @box.complete_shipping!
        elsif @box.aasm_state == "shipping_in_progress"
          @box.complete_shipping!
        end

        format.html { redirect_to box_requests_path, notice: 'Box design was successfully claimed.' }
        format.json { render :show, status: :ok, location: @box }
      else
        format.html { render :edit }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def box_shipment_params
    require(:box).permit(
        :shipped_by_id,
        :shipped_at,
        :shipping_payment_id,
        :shipment_tracking_number,
    )
  end

  def box_claim_scope
    policy_scope(Box, policy_scope_class: BoxPolicy::ShipmentScope)
  end
end
