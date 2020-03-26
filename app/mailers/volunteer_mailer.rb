# frozen_string_literal: true

class VolunteerMailer < ApplicationMailer
  attr_accessor :recipient

  def welcome_email(volunteer)
    @volunteer = volunteer
    mail(
      to: User.find(@volunteer.user.id).email,
      subject: 'Welcome to Voices of Consent!'
    )
  end

  def box_request_email(volunteer)
    @volunteer = volunteer
    mail(
      to: User.find(@volunteer.user.id).email,
      subject: 'A Box Request has been sent'
    )
  end

  def review_solicitation_email(volunteer, box_request)
    @recipient = volunteer
    @box_request = box_request
    mail(
      to: @recipient.email, subject: 'Voices of Consent BoxRequest needs Review'
    )
  end

  def design_solicitation_email(volunteer, box_request)
    @recipient = volunteer
    @box_request = box_request
    mail(to: @recipient.email, subject: 'Voices of Consent Box needs Design')
  end

  def assembly_solicitation_email(volunteer, box_request)
    @recipient = volunteer
    @box_request = box_request
    mail(to: @recipient.email, subject: 'Voices of Consent Box needs Assembly')
  end

  def research_solicitation_email(volunteer, box_request)
    @recipient = volunteer
    @box_request = box_request
    mail(
      to: @recipient.email, subject: 'Voices of Consent BoxItem needs Research'
    )
  end

  def shipping_solicitation_email(volunteer, box_request)
    @recipient = volunteer
    @box_request = box_request
    mail(to: @recipient.email, subject: 'Voices of Consent Box needs Shipment')
  end
end
