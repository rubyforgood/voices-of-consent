# frozen_string_literal: true

json.extract! meeting,
              :id,
              :meeting_type_id,
              :title,
              :location_id,
              :start_time,
              :end_time,
              :tenative,
              :created_at,
              :updated_at
json.url meeting_url(meeting, format: :json)
