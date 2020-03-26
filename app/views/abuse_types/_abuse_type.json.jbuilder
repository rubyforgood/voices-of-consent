# frozen_string_literal: true

json.extract! abuse_type, :id, :name, :created_at, :updated_at
json.url abuse_types_url(abuse_type, format: :json)
