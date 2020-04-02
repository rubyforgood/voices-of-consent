# frozen_string_literal: true

class BoxRequestTriageController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    if params[:boxRequest].nil? || request_params.empty?
      head :unprocessable_entity
      return
    end

    @payload = request_params
    requester = Requester.new

    %i[
      first_name
      last_name
      email
      phone
      street_address
      city
      state
      zip
      county
    ].each do |requester_attribute|
      requester.assign_attributes(requester_attribute => @payload[requester_attribute])
    end

    # making is_underage to underage
    requester.underage = @payload[:is_underage]

    # nil checking these four
    %i[ok_to_email ok_to_text ok_to_call ok_to_mail].each do |requester_attribute|
      value = @payload[requester_attribute]
      value = false if value.nil?
      requester.assign_attributes(requester_attribute => value)
    end

    requester.save!

    box_request = requester.box_requests.build
    @abuse_types_response = @payload[:abuse_types]

    %i[
      is_interested_in_counseling_services
      is_interested_in_health_services
      is_safe
      question_re_affect
      question_re_current_situation
      question_re_if_not_self_completed
      question_re_referral_source
      summary
    ].each do |box_request_attribute|
      box_request.assign_attributes(box_request_attribute => @payload[box_request_attribute])
    end

    ### Prepopulate tags based on question data
    %i[
      is_interested_in_counseling_services
      is_interested_in_health_services
      is_safe
      is_underage
      abuse_types
    ].each do |box_request_attribute|
      BoxRequestTriageService.new(
        box_request,
        box_request_attribute,
        @payload,
        @abuse_types_response,
        params
      ).run
    end

    box_request.save!

    # Preserve requester's original abuse type submission data as box_request_abuse_types
    @abuse_types_response.each do |abuse_type|
      box_request.box_request_abuse_types.create!(
        abuse_type: AbuseType.where(name: abuse_type).first_or_create!
      )
    end

    requester_email = AutoEmailHandler.new('requester', box_request, current_user || User.first)
    volunteer_email = AutoEmailHandler.new('volunteer', box_request, current_user || User.first)

    render json: { "redirect_url": box_request_thank_you_path }, status: 200
  rescue ActiveRecord::RecordInvalid => e
    render json: { "error": e }, status: 422
  end

  private

  def request_params
    params.require(:boxRequest)
  end
end
