# frozen_string_literal: true

json.extract! inventory_tally,
              :id,
              :additional_location_info,
              :inventory_type_id,
              :storage_location_id,
              :created_at,
              :updated_at
json.url inventory_tally_url(inventory_tally, format: :json)
