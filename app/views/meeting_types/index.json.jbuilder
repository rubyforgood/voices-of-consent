# frozen_string_literal: true

json.array! @meeting_types,
            partial: 'meeting_types/meeting_type', as: :meeting_type
