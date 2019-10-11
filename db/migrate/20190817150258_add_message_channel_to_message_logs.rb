class AddMessageChannelToMessageLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :message_logs, :message_channel, :string
  end
end
