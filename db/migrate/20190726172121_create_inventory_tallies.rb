# frozen_string_literal: true

class CreateInventoryTallies < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_tallies do |t|
      t.string :additional_location_info
      # file_upload should be added lateer
      t.integer :cached_quantity

      t.timestamps
    end
  end
end
