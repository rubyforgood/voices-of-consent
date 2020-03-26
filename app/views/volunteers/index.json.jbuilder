# frozen_string_literal: true

json.array! @volunteers, partial: 'volunteers/volunteer', as: :volunteer
