class BoxRequestsController < ApplicationController
  before_action :set_box_request, only: %i[show edit update destroy]

  # GET /box_requests
  # GET /box_requests.json
  def index
    @box_requests = BoxRequest.order(created_at: :desc)

    if params[:filter_by].present?
      (filter_attr = params[:filter_by])
      @box_requests = @box_requests.public_send(filter_attr)
    end
  end

  # GET /box_requests/1
  # GET /box_requests/1.json
  def show
    @box_request = request_review_scope.find(params[:id])
  end

  # GET /box_requests/new
  def new
    @box_request = BoxRequest.new
  end

  # GET /box_requests/1/edit
  def edit
    @box_request = request_review_scope.find(params[:id])
  end

  # POST /box_requests
  # POST /box_requests.json
  def create
    @box_request = BoxRequest.new(box_request_params)

    respond_to do |format|
      if @box_request.save
        format.html { redirect_to box_requests_path, notice: 'Box request was successfully created.' }
        format.json { render :show, status: :created, location: @box_request }
      else
        format.html { render :new }
        format.json { render json: @box_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /box_requests/1
  # PATCH/PUT /box_requests/1.json
  def update
    respond_to do |format|
      @box_request.reviewed_by_id = current_user.id if @box_request.reviewed_by_id == nil
      if @box_request.aasm_state == "requested"
        @box_request.claim_review!
        @box_request.complete_review!
      elsif @box_request.aasm_state == "review_in_progress"
        @box_request.complete_review!
      end

      if @box_request.update(box_request_params)
        format.html { redirect_to box_requests_path, notice: 'Box request was successfully updated.' }
        format.json { render :show, status: :ok, location: @box_request }
      else
        format.html { render :edit }
        format.json { render json: @box_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /box_requests/1
  # DELETE /box_requests/1.json
  def destroy
    @box_request.destroy
    respond_to do |format|
      format.html { redirect_to box_requests_url, notice: 'Box request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def decline
    @box_request = request_review_scope.find(params[:id])
    if @box_request.reviewed_by_id != current_user.id

      respond_to do |format|
        if @box_request.decline_review!
          format.html { redirect_to box_request_decline_thank_you_path }
          format.json { render :show, status: :ok, location: @box_request }
        else

          format.html { redirect_to root_path, alert: 'Box request review decline failed.' }
          format.json { render :show, status: :ok, location: @box_request }
        end
      end
    else
      redirect_to edit_box_request_path(@box_request), notice: "You previously claimed review of this Box"
    end
  end

  def claim
    @box_request = request_review_scope.find(params[:id])

    if !@box_request.reviewed_by_id || @box_request.reviewed_by == current_user
      respond_to do |format|
        @box_request.reviewed_by = current_user
        if @box_request.save
          if @box_request.aasm_state == "requested"
            @box_request.claim_review!
          end

          format.html { redirect_to box_request_claim_thank_you_path(@box_request, "review"), notice: 'Box request review was successfully claimed.' }
          format.json { render :show, status: :ok, location: @box_request }
        else
          format.html { render :edit }
          format.json { render json: @box_request.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to box_request_already_claimed_path
    end
  end

  def claim_thank_you
    @box_request = request_review_scope.find(params[:id])
    @phase = params[:phase]
    if current_user
    else
      render layout: false
    end
  end

  # /box_requests/already_claimed
  def already_claimed
    render layout: false
  end

  # /box_requests/decline_thank_you
  def decline_thank_you
    render layout: false
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_box_request
    @box_request = BoxRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def box_request_params
    params.require(:box_request).permit(:question_re_current_situation,
                                        :question_re_affect,
                                        :question_re_referral_source,
                                        :question_re_if_not_self_completed,
                                        :summary,
                                        :reviewed_by_id,
                                        :reviewed_at,
                                        :tag_list,
                                        review_declined_by_ids: [],
    )
  end

  def request_review_scope
    policy_scope(BoxRequest, policy_scope_class: BoxPolicy::ReviewScope)
  end
end
