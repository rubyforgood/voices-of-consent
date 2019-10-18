FactoryBot.define do
  factory :message_log do
    messageable_type { "BoxRequest" }
    messageable_id { 1 }
    sent_by
    sendable_type { "Volunteer" }
    sendable_id { 1 }
  end
end
