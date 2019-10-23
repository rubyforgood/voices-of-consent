class BoxesController < ApplicationController
  before_action :set_box, only: [:show, :edit, :update, :destroy]
  before_action :set_locations, only: [:new, :create, :edit, :update]

  # GET /boxes
  # GET /boxes.json
  def index
    @boxes = Box.all
  end

  # GET /boxes/1
  # GET /boxes/1.json
  def show
  end

  # GET /boxes/new
  def new
    @box = Box.new
  end

  # GET /boxes/1/edit
  def edit
  end

  # POST /boxes
  # POST /boxes.json
  def create
    @box = Box.new(box_params)

    @box_request = BoxRequest.find(@box.box_request_id);
    @box_request.complete_review!

    respond_to do |format|
      if @box.save
        format.html { redirect_to @box, notice: 'Box was successfully created.' }
        format.json { render :show, status: :created, location: @box }
      else
        format.html { render :new }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boxes/1
  # PATCH/PUT /boxes/1.json
  def update
    respond_to do |format|
      if @box.update(box_params)
        if @box.is_shipped
          @box.complete_shipping!
        end
        format.html { redirect_to box_requests_path(id: @box), notice: 'Box was successfully updated.' }
        format.json { render :show, status: :ok, location: @box }
      else
        format.html { render :edit }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boxes/1
  # DELETE /boxes/1.json
  def destroy
    @box.destroy
    respond_to do |format|
      format.html { redirect_to boxes_url, notice: 'Box was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box
      @box = Box.find(params[:id])
    end

    def set_locations
      @assembly_locations = Location.order(:name).pluck(:name, :id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def box_params
      params.require(:box).permit(
          :box_request_id,
          :designed_by_id,
          :designed_at,
          :design_reviewed_by_id,
          :design_reviewed_at,
          :researched_by_id,
          :researched_at,
          :assembled_by_id,
          :assembled_at,
          :shipped_by_id,
          :shipped_at,
          :shipping_payment_id,
          :shipment_tracking_number,
          :followed_up_by,
          :followed_up_at,
          :assembly_location_id,
          assembly_declined_by_ids: [],
          research_declined_by_ids: [],
          shipping_declined_by_ids: [],
          followup_declined_by_ids: [],)
    end
end
