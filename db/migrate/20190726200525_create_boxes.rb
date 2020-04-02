# frozen_string_literal: true

class CreateBoxes < ActiveRecord::Migration[5.2]
  def change
    create_table :boxes do |t|
      t.references :box_request, foreign_key: true, null: false, index: true
      t.references :designed_by, foreign_table_name: :user, null: true, index: true
      t.references :design_reviewed_by, foreign_table_name: :user, null: true, index: true
      t.references :assembled_by, foreign_table_name: :user, null: true, index: true
      t.references :shipped_by, foreign_table_name: :user, null: true, index: true
      t.references :shipping_payment, foreign_table_name: :purchase, null: true, index: true
      t.datetime :shipped_at
      t.string :shipment_tracking_number

      t.timestamps
    end
  end
end
