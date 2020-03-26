# frozen_string_literal: true

class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[show edit update destroy]

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show; end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit; end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)

    respond_to do |format|
      if @purchase.save
        format.html do
          redirect_to @purchase, notice: 'Purchase was successfully created.'
        end
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new }
        format.json do
          render json: @purchase.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html do
          redirect_to @purchase, notice: 'Purchase was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json do
          render json: @purchase.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html do
        redirect_to purchases_url,
                    notice: 'Purchase was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def purchase_params
    params.require(:purchase).permit(
      :location_id,
      :total_price,
      :purchased_by_id,
      :reimbursed_by_id,
      :reimbursement_check_number,
      :reimbursement_status
    )
  end
end
