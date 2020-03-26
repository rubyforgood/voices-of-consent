# frozen_string_literal: true

class AddDesignedAtToBox < ActiveRecord::Migration[5.2]
  def change
    add_column :boxes, :designed_at, :datetime
  end
end
