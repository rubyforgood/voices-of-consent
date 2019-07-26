class VolunteerMailer < ApplicationMailer
    def welcome_email(volunteer)
        @volunteer = volunteer
        mail(to: User.find(@volunteer.user_id).email, subject: 'Welcome to Voices of Consent!')
    end
end
