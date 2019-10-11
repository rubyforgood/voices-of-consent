class VolunteerApplicationController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    if params[:volunteerApplication].nil? || application_params.empty?
      head :unprocessable_entity
      return
    end

    @payload = application_params
    volunteer = Volunteer.new

    [:first_name,
     :last_name,
     :phone,
     :street_address,
     :city,
     :state,
     :zip,
     :marketing_vector,
     :why_volunteer
   ].each do |volunteer_attribute|
      volunteer.assign_attributes(volunteer_attribute => @payload[volunteer_attribute])
    end

    #making is_underage to underage
    volunteer.underage = @payload[:is_underage]

    #nil checking these four
    [:ok_to_email,
     :ok_to_text,
     :ok_to_call,
     :ok_to_mail
   ].each do |volunteer_attribute|
      value = @payload[volunteer_attribute]
      value = false if value.nil?
      volunteer.assign_attributes(volunteer_attribute => value)
    end

    volunteer.save!

    render json: { "redirect_url": volunteers_thank_you_path },
           status: 200
  end

  private

  def application_params
    params.require(:volunteerApplication)
  end
end
