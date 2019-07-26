class CreateBoxItems < ActiveRecord::Migration[5.2]
  def change
    create_table :box_items do |t|
      t.integer :box_id
      t.integer :inventory_adjustment_id
      t.integer :researched_by_id
      t.boolean :added_to_box
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end
end
