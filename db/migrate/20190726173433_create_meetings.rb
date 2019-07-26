class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.references :meeting_type, foreign_key: true
      t.string :title
      t.references :location, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :tenative, null: false, default: true

      t.timestamps
    end
  end
end
