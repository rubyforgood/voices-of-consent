# frozen_string_literal: true

class BoxRequestAbuseTypesController < ApplicationController
  before_action :set_box_request_abuse_type, only: %i[show edit update destroy]

  # GET /box_request_abuse_types
  # GET /box_request_abuse_types.json
  def index
    @box_request_abuse_types = BoxRequestAbuseType.all
  end

  # GET /box_request_abuse_types/1
  # GET /box_request_abuse_types/1.json
  def show; end

  # GET /box_request_abuse_types/new
  def new
    @box_request_abuse_type = BoxRequestAbuseType.new
  end

  # GET /box_request_abuse_types/1/edit
  def edit; end

  # POST /box_request_abuse_types
  # POST /box_request_abuse_types.json
  def create
    @box_request_abuse_type =
      BoxRequestAbuseType.new(box_request_abuse_type_params)

    respond_to do |format|
      if @box_request_abuse_type.save
        format.html do
          redirect_to @box_request_abuse_type,
                      notice: 'Box request abuse type was successfully created.'
        end
        format.json do
          render :show, status: :created, location: @box_request_abuse_type
        end
      else
        format.html { render :new }
        format.json do
          render json: @box_request_abuse_type.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /box_request_abuse_types/1
  # PATCH/PUT /box_request_abuse_types/1.json
  def update
    respond_to do |format|
      if @box_request_abuse_type.update(box_request_abuse_type_params)
        format.html do
          redirect_to @box_request_abuse_type,
                      notice: 'Box request abuse type was successfully updated.'
        end
        format.json do
          render :show, status: :ok, location: @box_request_abuse_type
        end
      else
        format.html { render :edit }
        format.json do
          render json: @box_request_abuse_type.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /box_request_abuse_types/1
  # DELETE /box_request_abuse_types/1.json
  def destroy
    @box_request_abuse_type.destroy
    respond_to do |format|
      format.html do
        redirect_to box_request_abuse_types_url,
                    notice: 'Box request abuse type was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_box_request_abuse_type
    @box_request_abuse_type = BoxRequestAbuseType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def box_request_abuse_type_params
    params.require(:box_request_abuse_type).permit(
      :box_request_id,
      :abuse_type_id
    )
  end
end
