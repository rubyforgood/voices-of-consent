# frozen_string_literal: true

json.array! @box_request_abuse_types,
            partial: 'box_request_abuse_types/box_request_abuse_type',
            as: :box_request_abuse_type
