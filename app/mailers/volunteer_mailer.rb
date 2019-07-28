class VolunteerMailer < ApplicationMailer
    def welcome_email(volunteer)
        @volunteer = volunteer
        mail(to: User.find(@volunteer.user_id).email, subject: 'Welcome to Voices of Consent!')
    end

    def box_request_email(volunteer)
        @volunteer = volunteer
        mail(to: User.find(@volunteer.user_id).email, subject: 'A Box Request has been sent')
    end

    def box_design_email(box_id)
        #todo: query all volunteers that have permission to design boxes
        # @volunteers.each do |volunteer|
        # mail(to:)
        # pass url for the box design page for that box id
    end

    def box_assembly_email(box_id)
        #todo: query all volunteers that have permission to assemble boxes
        # @volunteers.each do |volunteer|
        # mail(to:)
        # pass url for the box assembly page for that box id
    end

    def box_shipping_email(box_id)
        #todo: query all volunteers that have permission to ship boxes
        # @volunteers.each do |volunteer|
        # mail(to:)
        # pass url for the box shipping page for that box id
    end
end
