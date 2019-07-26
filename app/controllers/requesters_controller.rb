class RequestersController < ApplicationController
  before_action :set_requester, only: [:show, :edit, :update, :destroy]

  # GET /requesters
  # GET /requesters.json
  def index
    @requesters = Requester.all
  end

  # GET /requesters/1
  # GET /requesters/1.json
  def show
  end

  # GET /requesters/new
  def new
    @requester = Requester.new
  end

  # GET /requesters/1/edit
  def edit
  end

  # POST /requesters
  # POST /requesters.json
  def create
    @requester = Requester.new(requester_params)

    respond_to do |format|
      if @requester.save
        format.html { redirect_to @requester, notice: 'Requester was successfully created.' }
        format.json { render :show, status: :created, location: @requester }
      else
        format.html { render :new }
        format.json { render json: @requester.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requesters/1
  # PATCH/PUT /requesters/1.json
  def update
    respond_to do |format|
      if @requester.update(requester_params)
        format.html { redirect_to @requester, notice: 'Requester was successfully updated.' }
        format.json { render :show, status: :ok, location: @requester }
      else
        format.html { render :edit }
        format.json { render json: @requester.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requesters/1
  # DELETE /requesters/1.json
  def destroy
    @requester.destroy
    respond_to do |format|
      format.html { redirect_to requesters_url, notice: 'Requester was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requester
      @requester = Requester.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requester_params
      params.require(:requester).permit(:first_name, :last_name, :email, :street_address, :city, :state, :zip, :county, :phone, :ok_to_email, :ok_to_text, :ok_to_call, :ok_to_mail, :underage)
    end
end
