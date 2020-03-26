# frozen_string_literal: true

json.array! @box_requests, partial: 'box_requests/box_request', as: :box_request
