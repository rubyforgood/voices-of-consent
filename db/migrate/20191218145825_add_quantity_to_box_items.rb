class AddQuantityToBoxItems < ActiveRecord::Migration[5.2]
  def change
    add_column :box_items, :quantity, :integer, default: 1
  end
end
