class AddAasmStateToBoxes < ActiveRecord::Migration[5.2]
  def change
    add_column :boxes, :aasm_state, :string
  end
end
