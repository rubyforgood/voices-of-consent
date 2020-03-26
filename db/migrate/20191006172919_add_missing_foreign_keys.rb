# frozen_string_literal: true

class AddMissingForeignKeys < ActiveRecord::Migration[5.2]
  def change
    # box_items table
    add_foreign_key :box_items, :boxes
    add_foreign_key :box_items, :inventory_types
    add_foreign_key :box_items, :users, column: :created_by_id
    add_foreign_key :box_items, :users, column: :researched_by_id
    add_foreign_key :box_items, :users, column: :updated_by_id

    # box_requests table
    add_foreign_key :box_requests, :requesters

    # boxes table
    add_foreign_key :boxes, :users, column: :designed_by_id
    add_foreign_key :boxes, :users, column: :design_reviewed_by_id
    add_foreign_key :boxes, :users, column: :assembled_by_id
    add_foreign_key :boxes, :users, column: :shipped_by_id
    add_foreign_key :boxes, :purchases, column: :shipping_payment_id

    # inventory_adjustments table
    add_foreign_key :inventory_tallies, :inventory_types

    # message_logs table
    add_foreign_key :message_logs, :users, column: :sent_to_id
    add_foreign_key :message_logs, :users, column: :sent_by_id

    # purchases table
    add_foreign_key :purchases, :users, column: :purchased_by_id
    add_foreign_key :purchases, :users, column: :reimbursed_by_id

    # taggings
    add_foreign_key :taggings, :tags

    # users
    add_foreign_key :users, :volunteers, column: :volunteer_id

    # volunteers
    add_foreign_key :volunteers, :locations, column: :university_location_id
  end
end
