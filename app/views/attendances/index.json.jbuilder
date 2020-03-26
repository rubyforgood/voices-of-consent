# frozen_string_literal: true

json.array! @attendances, partial: 'attendances/attendance', as: :attendance
