# frozen_string_literal: true

json.array! @meetings, partial: 'meetings/meeting', as: :meeting
