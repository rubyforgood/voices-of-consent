class AddMissingIndices < ActiveRecord::Migration[5.2]
  def change
    add_index :message_logs, :sent_to_id
    add_index :message_logs, :sent_by_id
    add_index :active_storage_attachments, :record_id
    add_index :volunteers, :university_location_id
  end
end
