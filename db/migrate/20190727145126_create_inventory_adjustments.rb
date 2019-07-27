class CreateInventoryAdjustments < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_adjustments do |t|
      t.timestamps
    end
  end
end
