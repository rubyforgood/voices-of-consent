# frozen_string_literal: true

class AddResearchedAtToBoxItems < ActiveRecord::Migration[5.2]
  def change
    add_column :box_items, :researched_at, :datetime
  end
end
