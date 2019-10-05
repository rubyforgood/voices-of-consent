volunteer = Volunteer.where(id: 1). # querying on id allows us to always find or create the "first" volunteer, regardless of the current name, etc
                      first_or_create!(first_name: '[changme]',
                                       last_name: "[in prod]",
                                       street_address: "[changme in prod]",
                                       city: "[changme in prod]",
                                       state: "ca",
                                       zip: "12345",
                                       ok_to_email: true,
                                       ok_to_text: true,
                                       ok_to_call: true,
                                       ok_to_mail: true,
                                       underage: false)

user = User.where(volunteer: volunteer).
            first_or_create!(email: 'change-me-in-prod@example.com',
                             password: 'password',
                             password_confirmation: 'password')

user.grant_all_permissions! if user.user_permissions.none?
