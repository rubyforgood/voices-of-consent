class BoxFollowUpController < ApplicationController

  def new
    @box = box_claim_scope.find(params[:box_id])
    @requester = @box.box_request.requester
  end

  def claim
    @box = box_claim_scope.find(params[:box_id])

    if !@box.followed_up_by_id || @box.followed_up_by == current_user
      respond_to do |format|
        @box.followed_up_by = current_user
        if @box.save
          if @box.aasm_state == "shipped"
            @box.claim_follow_up!
          end

          format.html { redirect_to box_request_claim_thank_you_path(@box.box_request, "follow_up"), notice: 'Box followup was successfully claimed.' }
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

  def complete
    @box = box_claim_scope.find(params[:box_id])

    respond_to do |format|
      @box.followed_up_by = current_user if @box.followed_up_by_id == nil

      if @box.save
        if @box.aasm_state == "shipped"
          @box.claim_follow_up!
          @box.complete_follow_up!
        elsif @box.aasm_state == "follow_up_in_progress"
          @box.complete_follow_up!
        end

        format.html { redirect_to box_requests_path, notice: 'Box follow up was successfully claimed.' }
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
        :followed_up_by_id,
        :followed_up_at,
    )
  end

  def box_claim_scope
    policy_scope(Box, policy_scope_class: BoxPolicy::ShipmentScope)
  end
end
