# frozen_string_literal: true

class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[show edit update destroy]

  # GET /attendances
  # GET /attendances.json
  def index
    @attendances = policy_scope(Attendance)
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show; end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit; end

  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html do
          redirect_to @attendance,
                      notice: 'Attendance was successfully created.'
        end
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json do
          render json: @attendance.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html do
          redirect_to @attendance,
                      notice: 'Attendance was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json do
          render json: @attendance.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html do
        redirect_to attendances_url,
                    notice: 'Attendance was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attendance_params
    params.require(:attendance).permit(
      :meeting_id,
      :user_id,
      :special_duties,
      :completed_hours
    )
  end
end
