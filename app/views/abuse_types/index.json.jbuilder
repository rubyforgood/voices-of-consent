# frozen_string_literal: true

json.array! @abuse_types, partial: 'abuse_types/abuse_type', as: :abuse_type
