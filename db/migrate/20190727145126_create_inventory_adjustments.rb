# frozen_string_literal: true

class CreateInventoryAdjustments < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_adjustments do |t|
      t.references :inventory_tally, foreign_key: true
      t.references :purchase, foreign_key: true
      t.references :box_item, foreign_key: true
      t.integer :total_cost
      t.integer :tally_quantity_start
      t.integer :tally_quantity_end
      t.integer :adjustment_quantity

      t.timestamps
    end
  end
end
