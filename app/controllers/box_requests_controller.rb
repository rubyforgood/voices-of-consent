class BoxRequestsController < ApplicationController
  before_action :set_box_request, only: %i[show edit update destroy]

  # GET /box_requests
  # GET /box_requests.json
  def index
    @box_requests = BoxRequest.all
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
        format.html { redirect_to @box_request, notice: 'Box request was successfully created.' }
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
      if @box_request.update(box_request_params)
        format.html { redirect_to @box_request, notice: 'Box request was successfully updated.' }
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_box_request
    @box_request = BoxRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def box_request_params
    params.require(:box_request).permit(:summary, :question_re_current_situation, :question_re_affect, :question_re_referral_source, :question_re_if_not_self_completed, :tag_list)
  end

  def request_review_scope
    policy_scope(BoxRequest, policy_scope_class: BoxPolicy::ReviewScope)
  end
end
