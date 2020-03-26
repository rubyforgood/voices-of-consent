# frozen_string_literal: true

json.array! @message_logs, partial: 'message_logs/message_log', as: :message_log
