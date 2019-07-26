json.extract! requester, :id, :first_name, :last_name, :email, :street_address, :city, :state, :zip, :county, :phone, :ok_to_email, :ok_to_text, :ok_to_call, :ok_to_mail, :underage, :created_at, :updated_at
json.url requester_url(requester, format: :json)
