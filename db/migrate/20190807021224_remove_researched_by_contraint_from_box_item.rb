# frozen_string_literal: true

class RemoveResearchedByContraintFromBoxItem < ActiveRecord::Migration[5.2]
  def up
    change_column :box_items, :researched_by_id, :integer, null: true, index: true
  end

  def down
    change_column :box_items, :researched_by_id, :integer, null: false, index: true
  end
end
