# frozen_string_literal: true

class AddApplicationQuestionsToVolunteers < ActiveRecord::Migration[5.2]
  def change
    change_table :volunteers do |t|
      t.text :marketing_vector
      t.text :why_volunteer
    end
  end
end
