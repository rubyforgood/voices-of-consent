class StreamlineInventoryCounts < ActiveRecord::Migration[5.2]
  def change
    remove_column :inventory_tallies, :cached_quantity, :integer
    remove_column :inventory_adjustments, :tally_quantity_end, :integer
    remove_column :inventory_adjustments, :tally_quantity_start, :integer
  end
end
