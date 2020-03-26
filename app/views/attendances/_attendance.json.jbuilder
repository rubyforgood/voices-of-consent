# frozen_string_literal: true

json.extract! attendance,
              :id,
              :meeting_id,
              :user_id,
              :special_duties,
              :completed_hours,
              :created_at,
              :updated_at
json.url attendance_url(attendance, format: :json)
