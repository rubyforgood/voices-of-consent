class CreateMessageLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :message_logs do |t|
      t.string :messageable_type
      t.integer :messageable_id
      t.text :content
      t.integer :delivery_type
      t.string :delivery_status
      t.integer :sent_to_id
      t.integer :sent_by_id

      t.timestamps
    end
  end
end
