class AddSubjectLineToMessageLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :message_logs, :subject_line, :string
  end
end
