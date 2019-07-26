class CreateCoreBoxItems < ActiveRecord::Migration[5.2]
  def change
    create_table :core_box_items do |t|
      t.references :abuse_type, foreign_key: true
      t.references :inventory_type, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
