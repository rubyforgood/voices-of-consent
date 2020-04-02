# frozen_string_literal: true

class AddAssemblyLocationToBox < ActiveRecord::Migration[5.2]
  def change
    add_reference :boxes, :assembly_location, foreign_key: { to_table: :locations }
  end
end
