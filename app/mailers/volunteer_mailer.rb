class VolunteerMailer < ApplicationMailer
    def welcome_email(volunteer)
        @volunteer = volunteer
        mail(to: User.find(@volunteer.user_id).email, subject: 'Welcome to Voices of Consent!')
    end

    def box_request_email(volunteer)
        @volunteer = volunteer
        mail(to: User.find(@volunteer.user_id).email, subject: 'A Box Request has been sent')
    end
end
