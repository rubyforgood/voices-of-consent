class MessageLog < ApplicationRecord
  belongs_to :messageable, :polymorphic => true
  belongs_to :sendable, :polymorphic => true
  belongs_to :sent_by, class_name: "User", foreign_key: :sent_by_id, inverse_of: :message_logs_sent

  scope :ordered, -> { order(created_at: :desc) }

  enum delivery_type: {
    text: 0,
    autoemail: 1,
    email: 2,
    phone: 3,
  }

  def self.log_autoemail(email_object, person, object, message_type, current_user)
    self.create!(delivery_type: self.delivery_types[:autoemail],
                 content: email_object.body.raw_source,
                 sendable_type: person.class,
                 sendable: person,
                 sent_by: current_user,
                 messageable_type: object.class,
                 messageable: object,
                 subject_line: email_object.subject,
                 message_channel: "email", # TODO should this field replace 'delivery_type' ?
                 message_type: message_type,
    )
  end
end
