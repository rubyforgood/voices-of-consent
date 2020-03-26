# frozen_string_literal: true

json.array! @volunteers do |volunteer|
  json.id volunteer.id
  json.name volunteer.name
end
