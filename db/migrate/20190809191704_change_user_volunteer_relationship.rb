class ChangeUserVolunteerRelationship < ActiveRecord::Migration[5.2]
  def change
    remove_reference :volunteers, :user
    add_reference    :users, :volunteer
  end
end
