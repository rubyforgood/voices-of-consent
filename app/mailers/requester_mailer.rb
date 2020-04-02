# frozen_string_literal: true

class RequesterMailer < ApplicationMailer
  attr_accessor :recipient

  def box_request_confirmation_email(_requester, box_request)
    @box_request = box_request
    @recipient = box_request.requester
    mail(to: @recipient.email, subject: 'Thank you for contacting Voices of Consent!')
  end
end
