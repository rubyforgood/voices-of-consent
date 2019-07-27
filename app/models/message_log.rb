class MessageLog < ApplicationRecord
    belongs_to :messageable, :polymorphic => true
    belongs_to :sent_by, class_name: "User", foreign_key: :sent_by_id, inverse_of: :message_logs_sent
    belongs_to :sent_to, class_name: "User", foreign_key: :sent_to_id, inverse_of: :message_logs_received
    enum delivery_type: [:text, :autoemail, :email, :phone]
end
