# frozen_string_literal: true

class RemoveMessagableTypeAndIdwIthNoEFromMessageLog < ActiveRecord::Migration[
  5.2
]
  def change
    remove_column :message_logs, :messageable_type, :string
    remove_column :message_logs, :messageable_id, :integer
  end
end
