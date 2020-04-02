# frozen_string_literal: true

class BoxDesignController < ApplicationController
  def new
    @box = box_claim_scope.find(params[:box_id])
    @box_items = @box.box_items
  end

  def claim
    @box = box_claim_scope.find(params[:box_id])

    if !@box.designed_by_id || @box.designed_by == current_user
      respond_to do |format|
        @box.designed_by = current_user

        if @box.save
          @box.claim_design! if @box.aasm_state == 'reviewed'

          format.html do
            redirect_to box_request_claim_thank_you_path(@box.box_request, 'design'),
                        notice: 'Box design was successfully claimed.'
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
    if @box.designed_by != current_user
      respond_to do |format|
        if @box.decline_design!
          format.html do
            redirect_to box_request_decline_thank_you_path(id: @box.box_request, phase: 'design')
          end
          format.json { render :show, status: :ok, location: @box }
        else
          format.html { redirect_to root_path, alert: 'Box design decline failed.' }
          format.json { render :show, status: :ok, location: @box }
        end
      end
    else
      redirect_to edit_box_path(@box), notice: 'You previously claimed design of this Box'
    end
  end

  def complete
    @box = box_claim_scope.find(params[:box_id])

    respond_to do |format|
      @box.designed_by = current_user unless @box.designed_by_id

      if @box.save
        if @box.aasm_state == 'reviewed'
          @box.claim_design!
          @box.complete_design!
        elsif @box.aasm_state == 'design_in_progress'
          @box.complete_design!
        end

        format.html do
          redirect_to box_requests_path, notice: 'Box design was successfully claimed.'
        end
        format.json { render :show, status: :ok, location: @box }
      else
        format.html { render :edit }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def box_design_params
    params.require(:box).permit(
      :designed_by_id,
      :designed_at,
      :design_reviewed_by_id,
      :design_reviewed_at
    )
  end

  def box_claim_scope
    policy_scope(Box, policy_scope_class: BoxPolicy::DesignScope)
  end
end
