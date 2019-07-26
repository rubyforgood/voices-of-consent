json.extract! volunteer, :id, :first_name, :last_name, :email, :street_address, :city, :state, :zip, :county, :phone, :university_location_id, :graduation_year, :ok_to_email, :ok_to_text, :ok_to_call, :ok_to_mail, :underage, :created_at, :updated_at
json.url volunteer_url(volunteer, format: :json)
