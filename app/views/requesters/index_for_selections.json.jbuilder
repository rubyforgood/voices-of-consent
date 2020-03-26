# frozen_string_literal: true

json.array! @requesters do |requester|
  json.id requester.id
  json.name requester.name
end
