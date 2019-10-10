class BoxAssemblyController < ApplicationController

  def new
    @box = box_claim_scope.find(params[:box_id])
  end

  def claim
    @box = box_claim_scope.find(params[:box_id])

    if !@box.assembled_by_id || @box.assembled_by == current_user
      respond_to do |format|
        @box.assembled_by = current_user
        if @box.save
          if @box.aasm_state == "researched"
            @box.claim_assembly!
          end

          format.html { redirect_to box_request_claim_thank_you_path(@box.box_request, "assembled"), notice: 'Box assembly was successfully claimed.' }
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
      @box.assembled_by = current_user if !@box.assembled_by_id

      if @box.save
        if @box.aasm_state == "researched"
          @box.claim_assembly!
          @box.complete_assembly!
        elsif @box.aasm_state == "assembly_in_progress"
          @box.complete_assembly!
        end

        format.html { redirect_to box_requests_path, notice: 'Box assembly was successfully claimed.' }
        format.json { render :show, status: :ok, location: @box }
      else
        format.html { render :edit }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def box_assembly_params
    require(:box).permit(
        :assembled_by_id,
        :assembled_at,
    )
  end

  def box_claim_scope
    policy_scope(Box, policy_scope_class: BoxPolicy::AssemblyScope)
  end
end
