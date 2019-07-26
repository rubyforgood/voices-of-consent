class InventoryTalliesController < ApplicationController
  before_action :set_inventory_tally, only: [:show, :edit, :update, :destroy]

  # GET /inventory_tallies
  # GET /inventory_tallies.json
  def index
    @inventory_tallies = InventoryTally.all
  end

  # GET /inventory_tallies/1
  # GET /inventory_tallies/1.json
  def show
  end

  # GET /inventory_tallies/new
  def new
    @inventory_tally = InventoryTally.new
  end

  # GET /inventory_tallies/1/edit
  def edit
  end

  # POST /inventory_tallies
  # POST /inventory_tallies.json
  def create
    @inventory_tally = InventoryTally.new(inventory_tally_params)

    respond_to do |format|
      if @inventory_tally.save
        format.html { redirect_to @inventory_tally, notice: 'Inventory tally was successfully created.' }
        format.json { render :show, status: :created, location: @inventory_tally }
      else
        format.html { render :new }
        format.json { render json: @inventory_tally.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_tallies/1
  # PATCH/PUT /inventory_tallies/1.json
  def update
    respond_to do |format|
      if @inventory_tally.update(inventory_tally_params)
        format.html { redirect_to @inventory_tally, notice: 'Inventory tally was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventory_tally }
      else
        format.html { render :edit }
        format.json { render json: @inventory_tally.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_tallies/1
  # DELETE /inventory_tallies/1.json
  def destroy
    @inventory_tally.destroy
    respond_to do |format|
      format.html { redirect_to inventory_tallies_url, notice: 'Inventory tally was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_tally
      @inventory_tally = InventoryTally.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_tally_params
      params.fetch(:inventory_tally, {})
    end
end
