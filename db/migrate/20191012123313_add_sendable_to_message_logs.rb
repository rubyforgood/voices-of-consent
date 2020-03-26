# frozen_string_literal: true

class AddSendableToMessageLogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :message_logs, :sendable, polymorphic: true
    remove_foreign_key :message_logs, :users
    remove_column :message_logs, :sent_to_id, :integer
  end
end
