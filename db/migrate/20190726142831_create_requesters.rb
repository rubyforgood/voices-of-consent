# frozen_string_literal: true

class CreateRequesters < ActiveRecord::Migration[5.2]
  def change
    create_table :requesters do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :county
      t.string :phone
      t.boolean :ok_to_email
      t.boolean :ok_to_text
      t.boolean :ok_to_call
      t.boolean :ok_to_mail
      t.boolean :underage

      t.timestamps
    end
  end
end
