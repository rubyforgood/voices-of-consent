class AddSendableToMessageLogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :message_logs, :sent_to_id, :integer
    remove_foreign_key :message_logs, :users, column: :sent_to_id
    add_reference :message_logs, :sendable, polymorphic: true
  end
end
