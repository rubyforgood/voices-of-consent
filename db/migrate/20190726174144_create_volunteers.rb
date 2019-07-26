class CreateVolunteers < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteers do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :county
      t.string :phone
      t.integer :university_location_id
      t.integer :graduation_year
      t.boolean :ok_to_email
      t.boolean :ok_to_text
      t.boolean :ok_to_call
      t.boolean :ok_to_mail
      t.boolean :underage

      t.timestamps
    end
  end
end
