json.extract! location, :id, :name, :street_address, :city, :state, :zip, :type, :created_at, :updated_at
json.url location_url(location, format: :json)
