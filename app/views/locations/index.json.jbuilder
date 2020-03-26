# frozen_string_literal: true

json.array! @locations, partial: 'locations/location', as: :location
