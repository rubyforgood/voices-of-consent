class InventoryTypesController < ApplicationControllee
  before_action :authenticate_user!
  before_action :set_inventory_type, only: [:show, :edit, :update, :destroy]

  # GET /inventory_types
  # GET /inventory_types.json
  def index
    @inventory_types = InventoryType.all
  end

  # GET /inventory_types/1
  # GET /inventory_types/1.json
  def show
  end

  # GET /inventory_types/new
  def new
    @inventory_type = InventoryType.new
  end

  # GET /inventory_types/1/edit
  def edit
  end

  # POST /inventory_types
  # POST /inventory_types.json
  def create
    @inventory_type = InventoryType.new(inventory_type_params)

    respond_to do |format|
      if @inventory_type.save
        format.html { redirect_to @inventory_type, notice: 'Inventory type was successfully created.' }
        format.json { render :show, status: :created, location: @inventory_type }
      else
        format.html { render :new }
        format.json { render json: @inventory_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_types/1
  # PATCH/PUT /inventory_types/1.json
  def update
    respond_to do |format|
      if @inventory_type.update(inventory_type_params)
        format.html { redirect_to @inventory_type, notice: 'Inventory type was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventory_type }
      else
        format.html { render :edit }
        format.json { render json: @inventory_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_types/1
  # DELETE /inventory_types/1.json
  def destroy
    @inventory_type.destroy
    respond_to do |format|
      format.html { redirect_to inventory_types_url, notice: 'Inventory type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_type
      @inventory_type = InventoryType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_type_params
      params.fetch(:inventory_type, {})
    end
end
