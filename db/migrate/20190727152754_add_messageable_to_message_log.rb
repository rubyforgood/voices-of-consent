class AddMessageableToMessageLog < ActiveRecord::Migration[5.2]
  def change
    add_reference :message_logs, :messageable, polymorphic: true
  end
end
