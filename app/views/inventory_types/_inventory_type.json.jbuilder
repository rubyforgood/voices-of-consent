# frozen_string_literal: true

json.extract! inventory_type, :id, :name, :description
json.url inventory_type_url(inventory_type, format: :json)
