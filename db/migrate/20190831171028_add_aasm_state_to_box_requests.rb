# frozen_string_literal: true

class AddAasmStateToBoxRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :box_requests, :aasm_state, :string
  end
end
