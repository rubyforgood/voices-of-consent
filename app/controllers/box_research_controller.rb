class BoxResearchController < ApplicationController

  def new
    @box = box_claim_scope.find(params[:box_id])
  end

  def claim
    @box = box_claim_scope.find(params[:box_id])

    if !@box.researched_by_id || @box.researched_by == current_user
      respond_to do |format|
        @box.researched_by = current_user
        if @box.save
          if @box.aasm_state == "designed"
            @box.claim_research!
          elsif @box.aasm_state == "researched"
            @box.mark_as_researched!
          end

          format.html { redirect_to box_request_claim_thank_you_path(@box.box_request, "research"), notice: 'Box research was successfully claimed.' }
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
    if @box.researched_by != current_user

      respond_to do |format|
        if @box.decline_research!
          format.html { redirect_to box_request_decline_thank_you_path(id: @box.box_request, phase: "research") }
          format.json { render :show, status: :ok, location: @box }
        else

          format.html { redirect_to root_path, alert: 'Box research decline failed.' }
          format.json { render :show, status: :ok, location: @box }
        end
      end
    else
      redirect_to edit_box_path(@box), notice: "You previously claimed research of this Box"
    end
  end

  def complete
    @box = box_claim_scope.find(params[:box_id])

    respond_to do |format|
      @box.researched_by = current_user if @box.researched_by_id == nil

      if @box.save
        if @box.aasm_state == "designed"
          @box.claim_research!
          @box.complete_research!
        elsif @box.aasm_state == "research_in_progress"
          @box.complete_research!
        elsif @box.aasm_state == "researched"
          @box.mark_as_researched!
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

  def box_research_params
    require(:box).permit(
        :researched_by_id,
        :researched_at,
    )
  end

  def box_claim_scope
    policy_scope(Box, policy_scope_class: BoxPolicy::ShipmentScope)
  end
end
