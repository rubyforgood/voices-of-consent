# frozen_string_literal: true

class CreateUserPermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_permissions do |t|
      t.references :user, foreign_key: true
      t.string :permission

      t.timestamps
    end
  end
end
