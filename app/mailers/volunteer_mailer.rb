class VolunteerMailer < ApplicationMailer
    def welcome_email(volunteer)
        @volunteer = volunteer
        mail(to: @volunteer.email, subject: 'Welcome to Voices Of Consent!')
    end
end
