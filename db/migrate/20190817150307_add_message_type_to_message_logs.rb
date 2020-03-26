# frozen_string_literal: true

class AddMessageTypeToMessageLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :message_logs, :message_type, :string
  end
end
