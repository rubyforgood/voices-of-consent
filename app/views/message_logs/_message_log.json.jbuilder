json.extract! message_log, :id, :messageable_type, :messageable_id, :content, :delivery_type, :delivery_status, :sent_to_id, :sent_by_id, :created_at, :updated_at
json.url message_log_url(message_log, format: :json)
