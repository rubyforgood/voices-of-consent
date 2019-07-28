class InventoryAdjustmentsController < ApplicationController
  before_action :set_inventory_adjustment, only: [:show, :edit, :update, :destroy]

  # GET /inventory_adjustments
  # GET /inventory_adjustments.json
  def index
    @inventory_adjustments = InventoryAdjustment.all
  end

  # GET /inventory_adjustments/1
  # GET /inventory_adjustments/1.json
  def show
  end

  # GET /inventory_adjustments/new
  def new
    @inventory_adjustment = InventoryAdjustment.new
  end

  # GET /inventory_adjustments/1/edit
  def edit
  end

  # POST /inventory_adjustments
  # POST /inventory_adjustments.json
  def create
    @inventory_adjustment = InventoryAdjustment.new(inventory_adjustment_params)

    respond_to do |format|
      if @inventory_adjustment.save
        format.html { redirect_to @inventory_adjustment, notice: 'Inventory adjustment was successfully created.' }
        format.json { render :show, status: :created, location: @inventory_adjustment }
      else
        format.html { render :new }
        format.json { render json: @inventory_adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_adjustments/1
  # PATCH/PUT /inventory_adjustments/1.json
  def update
    respond_to do |format|
      if @inventory_adjustment.update(inventory_adjustment_params)
        format.html { redirect_to @inventory_adjustment, notice: 'Inventory adjustment was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventory_adjustment }
      else
        format.html { render :edit }
        format.json { render json: @inventory_adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_adjustments/1
  # DELETE /inventory_adjustments/1.json
  def destroy
    @inventory_adjustment.destroy
    respond_to do |format|
      format.html { redirect_to inventory_adjustments_url, notice: 'Inventory adjustment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_adjustment
      @inventory_adjustment = InventoryAdjustment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_adjustment_params
      params.require(:inventory_adjustment).permit(:inventory_tally_id, :purchase_id, :box_item_id, :total_cost, :tally_quantity_start, :tally_quantity_end, :adjustment_quantity)
    end
end
