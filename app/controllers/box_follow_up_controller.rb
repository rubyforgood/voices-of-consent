# frozen_string_literal: true

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
          @box.claim_follow_up! if @box.aasm_state == 'shipped'

          format.html do
            redirect_to box_request_claim_thank_you_path(
              @box.box_request,
              'follow_up'
            ),
                        notice: 'Box followup was successfully claimed.'
          end
          format.json { render :show, status: :ok, location: @box }
        else
          format.html { render :edit }
          format.json do
            render json: @box.errors, status: :unprocessable_entity
          end
        end
      end
    else
      redirect_to box_request_already_claimed_path
    end
  end

  def decline
    @box = request_review_scope.find(params[:box_id])
    if @box.followed_up_by != current_user
      respond_to do |format|
        if @box.decline_follow_up!
          format.html do
            redirect_to box_request_decline_thank_you_path(
              id: @box.box_request, phase: 'follow_up'
            )
          end
          format.json { render :show, status: :ok, location: @box }
        else
          format.html do
            redirect_to root_path, alert: 'Box follow_up decline failed.'
          end
          format.json { render :show, status: :ok, location: @box }
        end
      end
    else
      redirect_to edit_box_path(@box),
                  notice: 'You previously claimed follow_up of this Box'
    end
  end

  def complete
    @box = box_claim_scope.find(params[:box_id])

    respond_to do |format|
      @box.followed_up_by = current_user if @box.followed_up_by_id.nil?

      if @box.save
        if @box.aasm_state == 'shipped'
          @box.claim_follow_up!
          @box.complete_follow_up!
        elsif @box.aasm_state == 'follow_up_in_progress'
          @box.complete_follow_up!
        end

        format.html do
          redirect_to box_requests_path,
                      notice: 'Box follow up was successfully claimed.'
        end
        format.json { render :show, status: :ok, location: @box }
      else
        format.html { render :edit }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def box_shipment_params
    require(:box).permit(:followed_up_by_id, :followed_up_at)
  end

  def box_claim_scope
    policy_scope(Box, policy_scope_class: BoxPolicy::ShipmentScope)
  end
end
