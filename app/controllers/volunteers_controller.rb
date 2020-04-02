# frozen_string_literal: true

class VolunteersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new thank_you]
  before_action :set_volunteer, only: %i[show edit update destroy]

  # GET /volunteers
  # GET /volunteers.json
  def index
    @volunteers = Volunteer.all
  end

  def index_for_selections
    @volunteers = Volunteer.all.map { |volunteer| { id: volunteer.id, name: volunteer.name } }
    respond_to { |format| format.json { render json: @volunteers } }
  end

  # GET /volunteers/1
  # GET /volunteers/1.json
  def show; end

  # GET /volunteers/new
  def new
    @volunteer = Volunteer.new
    render :new, layout: 'outreach_form_layout'
  end

  # GET /volunteers/1/edit
  def edit; end

  # POST /volunteers
  # POST /volunteers.json
  def create
    @volunteer = Volunteer.new(volunteer_params.merge(user: current_user))

    respond_to do |format|
      if @volunteer.save
        if @volunteer.ok_to_email?
          VolunteerMailer.welcome_email(@volunteer).deliver_later
          message_log =
            MessageLog.new(
              sendable: @volunteer,
              sent_by: User.find_by(vounteer_id: @volunteer.id),
              messageable: @volunteer,
              content: VolunteerMailer.welcome_email(@volunteer),
              delivery_type: 'autoemail',
              delivery_status: 'Sent'
            )
          message_log.save
        end

        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully created.' }
        format.json { render :show, status: :created, location: @volunteer }
      else
        format.html { render :new }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /volunteers/1
  # PATCH/PUT /volunteers/1.json
  def update
    respond_to do |format|
      if @volunteer.update(volunteer_params)
        format.html { redirect_to @volunteer, notice: 'Volunteer was successfully updated.' }
        format.json { render :show, status: :ok, location: @volunteer }
      else
        format.html { render :edit }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteers/1
  # DELETE /volunteers/1.json
  def destroy
    @volunteer.destroy
    respond_to do |format|
      format.html { redirect_to volunteers_url, notice: 'Volunteer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def thank_you
    respond_to { |format| format.html { render layout: 'outreach_form_layout' } }
  end

  def import
    if params[:file].nil?
      redirect_to volunteers_path, alert: 'CSV document not present.'
    else
      Volunteer.import_csv(params[:file].path)
      respond_to do |format|
        format.html { redirect_to volunteers_path, notice: 'Successfully Imported Data!!!' }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def volunteer_params
    params.require(:volunteer).permit(
      :first_name,
      :last_name,
      :street_address,
      :city,
      :state,
      :zip,
      :county,
      :phone,
      :university_location_id,
      :graduation_year,
      :ok_to_email,
      :ok_to_text,
      :ok_to_call,
      :ok_to_mail,
      :underage
    )
  end
end
