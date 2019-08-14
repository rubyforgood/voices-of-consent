class MeetingTypesController < ApplicationController
  before_action :set_meeting_type, only: [:show, :edit, :update, :destroy]

  # GET /meeting_types
  # GET /meeting_types.json
  def index
    @meeting_types = MeetingType.all
  end

  # GET /meeting_types/1
  # GET /meeting_types/1.json
  def show
  end

  # GET /meeting_types/new
  def new
    @meeting_type = MeetingType.new
  end

  # GET /meeting_types/1/edit
  def edit
  end

  # POST /meeting_types
  # POST /meeting_types.json
  def create
    @meeting_type = MeetingType.new(meeting_type_params)

    respond_to do |format|
      if @meeting_type.save
        format.html { redirect_to @meeting_type, notice: 'Meeting type was successfully created.' }
        format.json { render :show, status: :created, location: @meeting_type }
      else
        format.html { render :new }
        format.json { render json: @meeting_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meeting_types/1
  # PATCH/PUT /meeting_types/1.json
  def update
    respond_to do |format|
      if @meeting_type.update(meeting_type_params)
        format.html { redirect_to @meeting_type, notice: 'Meeting type was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting_type }
      else
        format.html { render :edit }
        format.json { render json: @meeting_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting_types/1
  # DELETE /meeting_types/1.json
  def destroy
    @meeting_type.destroy
    respond_to do |format|
      format.html { redirect_to meeting_types_url, notice: 'Meeting type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting_type
      @meeting_type = MeetingType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meeting_type_params
      params.require(:meeting_type).permit(:name, :description)
    end
end
