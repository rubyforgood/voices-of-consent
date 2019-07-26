class CreateMeetingTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :meeting_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
