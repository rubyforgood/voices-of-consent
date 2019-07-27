class BoxRequestTriageController < ApplicationController

  def create
    if request_params.empty?
      head :unprocessable_entity
      return
    end

    @payload = JSON.parse(request_params[:boxRequest]).with_indifferent_access

    requester = Requester.new

    #TODO some of the existing fields (is_interested_in_counseling_services, is_interested_in_health_services, question_re_affect, question_re_current_situation, question_re_if_not_self_completed, question_re_referral_source) are not in our db for the time being
    [:first_name,
     :last_name,
     :email,
     :street_address,
     :city,
     :state,
     :zip,
     :ok_to_email,
     :ok_to_text,
     :ok_to_call,
     :ok_to_mail].each do |attribute|
      requester.update(attribute => @payload[attribute])
    end

    requester.underage = @payload[:is_underage]
    
    requester.save!
  end

  private

  def request_params
    params.permit(:boxRequest)
  end
end