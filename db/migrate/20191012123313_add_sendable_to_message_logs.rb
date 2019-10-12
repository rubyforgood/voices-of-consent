class AddSendableToMessageLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :message_logs, :sent_to_id, :integer
    add_reference :message_logs, :sendable, polymorphic: true
  end
end
