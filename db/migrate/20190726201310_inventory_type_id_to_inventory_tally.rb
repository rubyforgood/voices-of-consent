# frozen_string_literal: true

class InventoryTypeIdToInventoryTally < ActiveRecord::Migration[5.2]
  def change
    add_reference :inventory_tallies, :inventory_type, index: true

    add_reference :inventory_tallies, :storage_location, index: true
    add_foreign_key :inventory_tallies, :locations, column: :storage_location_id
  end
end
