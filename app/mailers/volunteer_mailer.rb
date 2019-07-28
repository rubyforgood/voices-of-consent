class VolunteerMailer < ApplicationMailer
    def welcome_email(volunteer)
        @volunteer = volunteer
        mail(to: User.find(@volunteer.user_id).email, subject: 'Welcome to Voices of Consent!')
    end

    def box_request_email(box_request)
        #todo: update this so that we query
        # all volunteers which are permitted to review requests
        # volunteers.each do |volunteer|
        mail(to: '', subject: 'A Box Request has been received and needs review')
        # pass box request ID route as url_for (needs full path) to attach to the email button
        # for accept
    end
end
