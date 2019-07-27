json.extract! meeting_type, :id, :name, :description, :created_at, :updated_at
json.url meeting_type_url(meeting_type, format: :json)
