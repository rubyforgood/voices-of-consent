# frozen_string_literal: true

class ChangeBoxItemInventoryAdjustmentToItemType < ActiveRecord::Migration[5.2]
  def up
    remove_column :box_items, :inventory_adjustment_id, :integer, index: true
    add_reference :box_items, :inventory_type, null: false, index: true
  end

  def down
    add_column :box_items, :inventory_adjustment_id, :integer, index: true
    remove_reference :box_items, :inventory_type
  end
end
