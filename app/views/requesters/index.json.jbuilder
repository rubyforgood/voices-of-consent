# frozen_string_literal: true

json.array! @requesters, partial: 'requesters/requester', as: :requester
