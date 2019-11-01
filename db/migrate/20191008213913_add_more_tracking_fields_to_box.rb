class AddMoreTrackingFieldsToBox < ActiveRecord::Migration[5.2]
  def change
    add_column :boxes, :design_reviewed_at, :datetime
    add_reference :boxes, :researched_by, foreign_key: { to_table: :users }
    add_column :boxes, :researched_at,      :datetime
    add_column :boxes, :assembled_at,       :datetime
    add_column :boxes, :followed_up_at,   :datetime
    add_reference :boxes, :followed_up_by, foreign_key: { to_table: :users }

    add_column :boxes, :design_declined_by_ids, :string, array: true, default: []
    add_column :boxes, :research_declined_by_ids, :string, array: true, default: []
    add_column :boxes, :assembly_declined_by_ids, :string, array: true, default: []
    add_column :boxes, :shipping_declined_by_ids, :string, array: true, default: []
    add_column :boxes, :followup_declined_by_ids, :string, array: true, default: []

    add_column :inventory_types, :requires_research, :boolean, null: false, default: false, index: true
  end
end
