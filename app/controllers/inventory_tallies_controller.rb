# frozen_string_literal: true

class InventoryTalliesController < ApplicationController
  before_action :set_inventory_tally, only: %i[show edit update destroy]

  # GET /inventory_tallies
  # GET /inventory_tallies.json
  def index
    @inventory_tallies = InventoryTally.all.includes(:storage_location, :inventory_type)
  end

  # GET /inventory_tallies/1
  # GET /inventory_tallies/1.json
  def show; end

  # GET /inventory_tallies/new
  def new
    @inventory_tally = InventoryTally.new
  end

  # GET /inventory_tallies/1/edit
  def edit; end

  # POST /inventory_tallies
  # POST /inventory_tallies.json
  def create
    @inventory_tally = InventoryTally.new(inventory_tally_params)

    respond_to do |format|
      if @inventory_tally.save
        format.html do
          redirect_to @inventory_tally, notice: 'Inventory tally was successfully created.'
        end
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
        format.html do
          redirect_to @inventory_tally, notice: 'Inventory tally was successfully updated.'
        end
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
      format.html do
        redirect_to inventory_tallies_url, notice: 'Inventory tally was successfully destroyed.'
      end
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
    params.require(:inventory_tally).permit(
      :additional_location_info,
      :inventory_type_id,
      :storage_location_id
    )
  end
end
