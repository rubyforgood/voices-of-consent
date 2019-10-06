class AddMissingIndices < ActiveRecord::Migration[5.2]
  def change
    add_index :message_logs, :sent_to_id
    add_index :message_logs, :sent_by_id
  end
end
