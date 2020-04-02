# frozen_string_literal: true

class BoxAssemblyController < ApplicationController
  def new
    @box = box_claim_scope.find(params[:box_id])
    @box_items = @box.box_items
  end

  def claim
    @box = box_claim_scope.find(params[:box_id])

    if !@box.assembled_by_id || @box.assembled_by == current_user
      respond_to do |format|
        @box.assembled_by = current_user

        if @box.save
          @box.claim_assembly! if @box.aasm_state == 'researched'

          format.html do
            redirect_to box_request_claim_thank_you_path(@box.box_request, 'assembled'),
                        notice: 'Box assembly was successfully claimed.'
          end
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
    if @box.assembled_by != current_user
      respond_to do |format|
        if @box.decline_assembly!
          format.html do
            redirect_to box_request_decline_thank_you_path(id: @box.box_request, phase: 'assembly')
          end
          format.json { render :show, status: :ok, location: @box }
        else
          format.html { redirect_to root_path, alert: 'Box assembly decline failed.' }
          format.json { render :show, status: :ok, location: @box }
        end
      end
    else
      redirect_to edit_box_path(@box), notice: 'You previously claimed assembly of this Box'
    end
  end

  def complete
    @box = box_claim_scope.find(params[:box_id])

    respond_to do |format|
      @box.assembled_by = current_user unless @box.assembled_by_id

      if @box.save
        if @box.aasm_state == 'researched'
          @box.claim_assembly!
          @box.complete_assembly!
        elsif @box.aasm_state == 'assembly_in_progress'
          @box.complete_assembly!
        end

        format.html do
          redirect_to box_requests_path, notice: 'Box assembly was successfully claimed.'
        end
        format.json { render :show, status: :ok, location: @box }
      else
        format.html { render :edit }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def box_assembly_params
    require(:box).permit(:assembled_by_id, :assembled_at)
  end

  def box_claim_scope
    policy_scope(Box, policy_scope_class: BoxPolicy::AssemblyScope)
  end
end
