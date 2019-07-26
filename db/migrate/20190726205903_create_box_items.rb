class CreateBoxItems < ActiveRecord::Migration[5.2]
  def change
    create_table :box_items do |t|
      t.integer :box_id, index: true, null: false
      t.integer :inventory_adjustment_id, index: true, null: false
      t.integer :researched_by_id, index: true, null: false
      t.boolean :added_to_box
      t.integer :created_by_id, index: true, null: false
      t.integer :updated_by_id, index: true, null: false

      t.timestamps
    end
  end
end
