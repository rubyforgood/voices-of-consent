class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :meeting, foreign_key: true
      t.references :user, foreign_key: true
      t.string :special_duties
      t.boolean :completed_hours

      t.timestamps
    end
  end
end
