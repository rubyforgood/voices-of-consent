# frozen_string_literal: true

class MessageLogsController < ApplicationController
  before_action :set_message_log, only: %i[show edit update destroy]

  # GET /message_logs
  # GET /message_logs.json
  def index
    @message_logs = MessageLog.ordered.paginate(page: params[:page])
  end

  # GET /message_logs/1
  # GET /message_logs/1.json
  def show; end

  # GET /message_logs/new
  def new
    @message_log = MessageLog.new
  end

  # GET /message_logs/1/edit
  def edit; end

  # POST /message_logs
  # POST /message_logs.json
  def create
    @message_log = MessageLog.new(message_log_params)

    respond_to do |format|
      if @message_log.save
        format.html do
          redirect_to @message_log,
                      notice: 'Message log was successfully created.'
        end
        format.json { render :show, status: :created, location: @message_log }
      else
        format.html { render :new }
        format.json do
          render json: @message_log.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /message_logs/1
  # PATCH/PUT /message_logs/1.json
  def update
    respond_to do |format|
      if @message_log.update(message_log_params)
        format.html do
          redirect_to @message_log,
                      notice: 'Message log was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @message_log }
      else
        format.html { render :edit }
        format.json do
          render json: @message_log.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /message_logs/1
  # DELETE /message_logs/1.json
  def destroy
    @message_log.destroy
    respond_to do |format|
      format.html do
        redirect_to message_logs_url,
                    notice: 'Message log was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message_log
    @message_log = MessageLog.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_log_params
    params.require(:message_log).permit(
      :messageable_type,
      :messageable_id,
      :content,
      :delivery_type,
      :delivery_status,
      :sendable_type,
      :sendable_id,
      :sent_by_id
    )
  end
end
