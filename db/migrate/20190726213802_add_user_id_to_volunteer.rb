# frozen_string_literal: true

class AddUserIdToVolunteer < ActiveRecord::Migration[5.2]
  def change
    add_reference :volunteers, :user, index: true
  end
end
