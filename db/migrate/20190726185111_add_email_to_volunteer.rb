class AddEmailToVolunteer < ActiveRecord::Migration[5.2]
  def change
    add_column :volunteers, :email, :string
  end
end
