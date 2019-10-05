FactoryBot.define do
  factory :message_log do
    messageable
    sent_by
    sent_to
  end
end
