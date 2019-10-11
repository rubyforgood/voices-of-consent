class RenameLocationTypeToLocationType < ActiveRecord::Migration[5.2]
  def change
    rename_column :locations, :type, :location_type
  end
end
